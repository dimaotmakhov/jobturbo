import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/JobListing.dart';
import '../models/JobListingStatus.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';

class JobDetailScreen extends StatefulWidget {
  final JobListing job;

  const JobDetailScreen({super.key, required this.job});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  bool _isLoading = true;
  bool _isUpdating = false;
  String? _error;
  JobListing? _jobDetails;
  List<Map<String, dynamic>> _parsedLinks = [];
  bool _wasViewed = false;

  @override
  void initState() {
    super.initState();
    _loadJobDetails();
    _markAsViewed();
  }

  Future<void> _markAsViewed() async {
    if (widget.job.isViewed == true) return;

    try {
      const graphQLDocument = '''
        mutation UpdateJobListing(\$input: UpdateJobListingInput!) {
          updateJobListing(input: \$input) {
            id
            isViewed
          }
        }
      ''';

      final response = await Amplify.API
          .mutate(
              request: GraphQLRequest<String>(
            document: graphQLDocument,
            variables: {
              "input": {
                "id": widget.job.id,
                "isViewed": true,
                "sortKey": "sortKey",
              }
            },
          ))
          .response;

      final responseData = jsonDecode(response.data!);

      if (responseData['errors'] != null) {
        final errors = responseData['errors'] as List;
        final errorMessage = errors.first['message'] as String;
        throw errorMessage;
      }

      setState(() {
        _wasViewed = true;
      });
    } catch (e) {
      safePrint('Failed to mark job as viewed: $e');
    }
  }

  String _getErrorMessage(dynamic error, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (error is String && error.contains('ExecutionTimeoutException')) {
      return localizations.errorRequestTimeout;
    }
    return localizations.errorLoadingJobPosting;
  }

  JobListingStatus _parseStatus(String status) {
    switch (status.toUpperCase()) {
      case 'APPLIED':
        return JobListingStatus.APPLIED;
      case 'NO_ANSWER':
        return JobListingStatus.NO_ANSWER;
      case 'REJECTED':
        return JobListingStatus.REJECTED;
      case 'SUCCESSFUL':
        return JobListingStatus.SUCCESSFUL;
      default:
        return JobListingStatus.NO_ANSWER;
    }
  }

  Future<void> _loadJobDetails() async {
    try {
      const graphQLDocument = '''
        mutation JobListingMutation(\$id: String!) {
          jobListingMutation(id: \$id) {
            id
            companyName
            jobPreview
            position
            logo
            keywords
            isApplied
            status
            createdAt
            updatedAt
            links
            isViewed
          }
        }
      ''';

      final response = await Amplify.API
          .query(
              request: GraphQLRequest<String>(
            document: graphQLDocument,
            variables: <String, String>{"id": widget.job.id},
          ))
          .response;

      final responseData = jsonDecode(response.data!);

      // Check for GraphQL errors
      if (responseData['errors'] != null) {
        final errors = responseData['errors'] as List;
        final errorMessage = errors.first['message'] as String;
        throw errorMessage;
      }

      final jobData = responseData["jobListingMutation"];

      // Check if job data is null
      if (jobData == null) {
        throw 'Job posting not found or no longer available';
      }

      // Parse links
      if (jobData['links'] != null) {
        _parsedLinks = (jobData['links'] as List).map((linkStr) {
          // First parse to get the unescaped JSON string
          final unescaped = jsonDecode(linkStr);
          // Then parse the actual link object
          return jsonDecode(unescaped) as Map<String, dynamic>;
        }).toList();
      }

      setState(() {
        _jobDetails = JobListing(
          id: jobData['id'],
          sortKey: jobData['id'], // Using id as sortKey
          companyName: jobData['companyName'],
          jobPreview: jobData['jobPreview'],
          position: jobData['position'],
          logo: jobData['logo'],
          keywords: jobData['keywords']?.cast<String>(),
          isApplied: jobData['isApplied'],
          status: _parseStatus(jobData['status'] ?? 'NO_ANSWER'),
          createdAt: jobData['createdAt'] != null
              ? TemporalDateTime.fromString(jobData['createdAt'])
              : null,
          updatedAt: jobData['updatedAt'] != null
              ? TemporalDateTime.fromString(jobData['updatedAt'])
              : null,
          isViewed: jobData['isViewed'],
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = _getErrorMessage(e, context);
        _isLoading = false;
      });
    }
  }

  Future<void> _markAsApplied() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      const graphQLDocument = '''
        mutation UpdateJobListing(\$input: UpdateJobListingInput!) {
          updateJobListing(input: \$input) {
            id
            isApplied
            status
          }
        }
      ''';

      final response = await Amplify.API
          .mutate(
              request: GraphQLRequest<String>(
            document: graphQLDocument,
            variables: {
              "input": {
                "id": widget.job.id,
                "isApplied": true,
                "status": JobListingStatus.APPLIED.name,
                "sortKey": "sortKey",
              }
            },
          ))
          .response;

      final responseData = jsonDecode(response.data!);

      // Check for GraphQL errors
      if (responseData['errors'] != null) {
        final errors = responseData['errors'] as List;
        final errorMessage = errors.first['message'] as String;
        throw errorMessage;
      }

      final updatedData = responseData["updateJobListing"];
      if (updatedData != null) {
        setState(() {
          if (_jobDetails != null) {
            _jobDetails = _jobDetails!.copyWith(
              isApplied: true,
              status: JobListingStatus.APPLIED,
            );
          }
          _isUpdating = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.applied),
              backgroundColor: Colors.green,
            ),
          );

          // Pop back to previous screen with a result to trigger refresh
          Navigator.of(context).pop(<bool>[true, _wasViewed]);
        }
      }
    } catch (e) {
      setState(() {
        _isUpdating = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${_getErrorMessage(e, context)}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

  Widget _buildErrorScreen() {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.position ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(<bool>[false, _wasViewed]),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 24),
              Text(
                _error ?? localizations.errorLoadingJobPosting,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _error = null;
                  });
                  _loadJobDetails();
                },
                icon: const Icon(Icons.refresh),
                label: Text(localizations.tryAgain),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () =>
                    Navigator.of(context).pop(<bool>[false, _wasViewed]),
                child: Text(localizations.goBack),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoPlaceholder(BuildContext context, String? companyName) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final initial =
        (companyName?.isNotEmpty == true) ? companyName![0].toUpperCase() : '?';

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceVariant
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          initial,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.job.position ?? ''),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return _buildErrorScreen();
    }

    final job = _jobDetails ?? widget.job;

    return WillPopScope(
      onWillPop: () async {
        // Pop with a tuple of (wasApplied, wasViewed)
        Navigator.of(context).pop(<bool>[false, _wasViewed]);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(job.position ?? ''),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Pop with a tuple of (wasApplied, wasViewed)
              Navigator.of(context).pop(<bool>[false, _wasViewed]);
            },
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Header
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
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
                          child: job.logo != null && job.logo!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: job.logo!,
                                  width: 80,
                                  height: 80,
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
                                          context, job.companyName),
                                  memCacheWidth: 160, // 2x the display size
                                  memCacheHeight: 160, // 2x the display size
                                )
                              : _buildLogoPlaceholder(context, job.companyName),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.companyName ?? '',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              job.position ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Keywords
                  if (job.keywords != null && job.keywords!.isNotEmpty) ...[
                    Text(
                      localizations.skillsAndTechnologies,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: job.keywords!.map((keyword) {
                        return Chip(
                          label: Text(keyword),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          labelStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Company Description
                  Text(
                    localizations.aboutTheCompany,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.jobPreview ?? localizations.noCompanyDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),

                  // Application Links
                  if (_parsedLinks.isNotEmpty) ...[
                    Text(
                      localizations.applyVia,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    ..._parsedLinks.map((link) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(Icons.link),
                            title: Text(link['name'] ?? ''),
                            trailing: const Icon(Icons.open_in_new),
                            onTap: () => _launchUrl(link['href']),
                          ),
                        )),
                  ],
                ],
              ),
            ),
            // Fixed position "Mark as Applied" button at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: FilledButton(
                  onPressed: job.isApplied == true || _isUpdating
                      ? null
                      : _markAsApplied,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: _isUpdating
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          job.isApplied == true
                              ? localizations.applied
                              : localizations.markAsApplied,
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
