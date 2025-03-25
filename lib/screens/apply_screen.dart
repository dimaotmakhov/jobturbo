import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/JobListing.dart';
import 'job_detail_screen.dart';
import 'dart:convert';
import '../l10n/app_localizations.dart';
import 'dart:async';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/foundation.dart';

class ApplyScreen extends ConsumerStatefulWidget {
  final dynamic mockQueryProvider;

  const ApplyScreen({super.key, this.mockQueryProvider});

  @override
  ConsumerState<ApplyScreen> createState() => _ApplyScreenState();
}

class _ApplyScreenState extends ConsumerState<ApplyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<JobListing> _jobListings = [];
  bool _isLoading = true;
  bool _isRefreshing = false;
  Timer? _refreshTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _isRefreshing = false;
    });

    try {
      if (!kIsWeb) {
        await RevenueCatUI.presentPaywallIfNeeded("pro");
      }
    } catch (e) {
      safePrint('Error presenting paywall: $e');
    }

    // Set a timer to ensure loading state is cleared even if something goes wrong
    _refreshTimer?.cancel();
    _refreshTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isRefreshing = false;
        });
      }
    });

    try {
      if (mounted) {
        await _refreshJobListings(isInitialLoad: true);
      }
    } catch (e) {
      safePrint('Error refreshing job listings: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isRefreshing = false;
        });
      }
    }
  }

  String listJobListingsQuery = '''
query ListRequestsByDate(
  \$createdAt: ModelStringKeyConditionInput
  \$filter: ModelJobListingFilterInput
  \$limit: Int
  \$nextToken: String
  \$owner: String!
  \$sortDirection: ModelSortDirection
) {
  listJobListingByOwnerAndCreatedAt(
    createdAt: \$createdAt
    filter: \$filter
    limit: \$limit
    nextToken: \$nextToken
    owner: \$owner
    sortDirection: \$sortDirection
  ) {
    items {
      id
      companyName
      position
      logo
      keywords
      isApplied
      status
      createdAt
      updatedAt
      isViewed
    }
    nextToken
  }
}
''';

  String updateJobListingMutation = '''
mutation UpdateJobListing(
  \$input: UpdateJobListingInput!
) {
  updateJobListing(input: \$input) {
    id
    isApplied
    status
    isViewed
    updatedAt
  }
}
''';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<int> _getQueryLimit() async {
    if (kIsWeb) return 1000;
    
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all["pro"]?.isActive == true ? 1000 : 10;
    } catch (e) {
      safePrint('Error fetching purchaser info: $e');
      return 10; // Default to 10 if we can't check subscription
    }
  }

  Future<void> _refreshJobListings({required bool isInitialLoad}) async {
    if (_isRefreshing && !isInitialLoad) return;

    final result = await Amplify.Auth.fetchAuthSession();
    String owner = result.toJson()['userSub'] as String;

    try {
      if (!isInitialLoad) {
        setState(() {
          _isRefreshing = true;
        });
      }

      final limit = await _getQueryLimit();

      final request = GraphQLRequest<String>(
        document: listJobListingsQuery,
        variables: {
          'limit': limit,
          'sortDirection': 'DESC',
          'owner': '$owner::$owner',
        },
      );

      final response = widget.mockQueryProvider != null
          ? await widget.mockQueryProvider()
          : await Amplify.API.query(request: request).response;

      // Cancel the refresh timer since we got a response
      _refreshTimer?.cancel();

      if (!mounted) return;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        setState(() {
          _isLoading = false;
          _isRefreshing = false;
        });
        return;
      }

      Map<String, dynamic> jsonMap = json.decode(response.data!);
      final jobListingsJson = jsonMap['listJobListingByOwnerAndCreatedAt']
          ['items'] as List<dynamic>;

      if (!mounted) return;

      setState(() {
        _jobListings =
            jobListingsJson.map((item) => JobListing.fromJson(item)).toList();
        _isLoading = false;
        _isRefreshing = false;
      });
    } catch (e) {
      safePrint('Query failed: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isRefreshing = false;
        });
      }
    }
  }

  Future<void> _markAsViewed(JobListing job) async {
    try {
      // Update local state immediately
      setState(() {
        final index = _jobListings.indexWhere((item) => item.id == job.id);
        if (index != -1) {
          _jobListings[index] = _jobListings[index].copyWith(isViewed: true);
        }
      });

      final request = GraphQLRequest<String>(
        document: updateJobListingMutation,
        variables: {
          'input': {
            'id': job.id,
            'isViewed': true,
            'sortKey': 'sortKey',
          }
        },
      );

      final response = await Amplify.API.mutate(request: request).response;

      if (!mounted) return;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        // Revert local state if mutation failed
        await _refreshJobListings(isInitialLoad: false);
      }
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
      if (mounted) {
        // Revert local state if mutation failed
        await _refreshJobListings(isInitialLoad: false);
      }
    }
  }

  Future<void> _applyToJob(JobListing job) async {
    try {
      final request = GraphQLRequest<String>(
        document: updateJobListingMutation,
        variables: {
          'input': {
            'id': job.id,
            'isApplied': false,
            'status': 'APPLIED',
            'sortKey': 'sortKey',
          }
        },
      );

      final response = await Amplify.API.mutate(request: request).response;

      if (!mounted) return;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }

      // Refresh the list to show updated status
      await _refreshJobListings(isInitialLoad: false);
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  List<JobListing> get _toApplyListings =>
      _jobListings.where((job) => job.isApplied == false).toList();

  List<JobListing> get _appliedListings =>
      _jobListings.where((job) => job.isApplied == true).toList();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(text: localizations.toApply),
          Tab(text: localizations.applied),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildJobList(_toApplyListings, showApplyButton: false),
                    _buildJobList(_appliedListings, showApplyButton: true),
                  ],
                ),
              ),
            ],
          ),
          if (_isRefreshing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildJobList(List<JobListing> listings,
      {required bool showApplyButton}) {
    final localizations = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refreshJobListings(isInitialLoad: false),
      child: listings.isEmpty
          ? ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2 - 100,
                  child: Center(
                    child: Text(localizations.noJobListings),
                  ),
                ),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listings.length,
              itemBuilder: (context, index) {
                return _JobListingItem(
                  key: ValueKey(listings[index].id),
                  listing: listings[index],
                  onApply:
                      showApplyButton ? () => _applyToJob(listings[index]) : null,
                  onView: () => _markAsViewed(listings[index]),
                );
              },
            ),
    );
  }
}

class _JobListingItem extends StatelessWidget {
  final JobListing listing;
  final VoidCallback? onApply;
  final VoidCallback onView;

  const _JobListingItem({
    super.key,
    required this.listing,
    this.onApply,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () async {
                  // Mark as viewed immediately when opening
                  if (listing.isViewed == false) {
                    onView();
                  }

                  final result = await Navigator.push<List<bool>>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailScreen(job: listing),
                    ),
                  );

                  if (result != null) {
                    final [wasApplied, wasViewed] = result;
                    // If the job was marked as applied or viewed, refresh the listings
                    if (wasApplied || wasViewed) {
                      final applyScreenState =
                          context.findAncestorStateOfType<_ApplyScreenState>();
                      if (applyScreenState != null) {
                        await applyScreenState._refreshJobListings(isInitialLoad: false);
                      }
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Company Logo
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isDark
                                ? theme.colorScheme.surfaceVariant
                                : theme.colorScheme.outline.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: listing.logo != null &&
                                  listing.logo!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: listing.logo!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: isDark
                                        ? theme.colorScheme.surfaceVariant
                                        : theme.colorScheme.surface,
                                    child: const Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      _buildLogoPlaceholder(
                                          context, listing.companyName),
                                  memCacheWidth: 100,
                                  memCacheHeight: 100,
                                )
                              : _buildLogoPlaceholder(
                                  context, listing.companyName),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Job Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listing.companyName ?? '',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              listing.position ?? '',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            if (listing.keywords != null)
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: listing.keywords!.map((keyword) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? theme.colorScheme.surfaceVariant
                                          : theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: theme.colorScheme.outline
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                    child: Text(
                                      keyword,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (onApply != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: onApply,
                        icon: const Icon(Icons.remove_circle_outline),
                        label: Text(localizations.markAsNotApplied),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (listing.isViewed == false)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  localizations.newBadge,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogoPlaceholder(BuildContext context, String? companyName) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final initial =
        (companyName?.isNotEmpty == true) ? companyName![0].toUpperCase() : '?';

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          initial,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
