import 'package:flutter/material.dart';
import 'package:jobturbo/l10n/app_localizations.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'job_detail_screen.dart';
import '../models/JobListing.dart';

class JobListScreen extends StatefulWidget {
  final String title;
  final List<JobListing> jobListings;

  const JobListScreen({
    super.key,
    required this.title,
    required this.jobListings,
  });

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  String _getEmptyMessage(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    if (widget.title.contains(localizations.appliedJobs)) {
      return localizations.noAppliedJobs;
    } else if (widget.title.contains(localizations.pendingJobs)) {
      return localizations.noPendingJobs;
    } else if (widget.title.contains(localizations.rejectedJobs)) {
      return localizations.noRejectedJobs;
    } else if (widget.title.contains(localizations.successfulApplications)) {
      return localizations.noSuccessfulJobs;
    }
    return localizations.noJobs;
  }

  Future<void> _updateJobStatus(String jobId, String newStatus) async {
    try {
      final updateMutation = '''
        mutation UpdateJobListing(
          \$id: ID!
          \$status: JobListingStatus!
        ) {
          updateJobListing(input: {
            id: \$id
            status: \$status
          }) {
            id
            status
          }
        }
      ''';

      final request = GraphQLRequest<String>(
        document: updateMutation,
        variables: {
          'id': jobId,
          'status': newStatus,
        },
      );

      final response = await Amplify.API.mutate(request: request).response;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }

      // Remove the job from the list after status update
      setState(() {
        widget.jobListings.removeWhere((job) => job.id == jobId);
      });
    } on ApiException catch (e) {
      safePrint('Mutation failed: $e');
    }
  }

  bool get _isAppliedList {
    final localizations = AppLocalizations.of(context)!;
    return widget.title == localizations.appliedJobs;
  }

  bool get _isNoAnswerList {
    final localizations = AppLocalizations.of(context)!;
    return widget.title == localizations.pendingJobs;
  }

  List<Widget> _buildStatusButtons(String jobId) {
    final List<Widget> buttons = [];

    if (_isAppliedList) {
      buttons.addAll([
        IconButton(
          icon: const Icon(Icons.hourglass_empty),
          color: Colors.orange,
          onPressed: () => _updateJobStatus(jobId, 'NO_ANSWER'),
          tooltip: 'No Answer',
        ),
        IconButton(
          icon: const Icon(Icons.cancel),
          color: Colors.red,
          onPressed: () => _updateJobStatus(jobId, 'REJECTED'),
          tooltip: 'Rejected',
        ),
        IconButton(
          icon: const Icon(Icons.check_circle),
          color: Colors.green,
          onPressed: () => _updateJobStatus(jobId, 'SUCCESSFUL'),
          tooltip: 'Successful',
        ),
      ]);
    } else if (_isNoAnswerList) {
      buttons.addAll([
        IconButton(
          icon: const Icon(Icons.cancel),
          color: Colors.red,
          onPressed: () => _updateJobStatus(jobId, 'REJECTED'),
          tooltip: 'Rejected',
        ),
        IconButton(
          icon: const Icon(Icons.check_circle),
          color: Colors.green,
          onPressed: () => _updateJobStatus(jobId, 'SUCCESSFUL'),
          tooltip: 'Successful',
        ),
      ]);
    }

    return buttons;
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.jobListings.isEmpty
          ? Center(
              child: Text(
                _getEmptyMessage(context),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.jobListings.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailScreen(
                                  job: widget.jobListings[index]),
                            ),
                          );
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
                                        : theme.colorScheme.outline
                                            .withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: widget.jobListings[index].logo !=
                                              null &&
                                          widget.jobListings[index].logo!
                                              .isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              widget.jobListings[index].logo!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: isDark
                                                ? theme
                                                    .colorScheme.surfaceVariant
                                                : theme.colorScheme.surface,
                                            child: const Center(
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              _buildLogoPlaceholder(
                                                  context,
                                                  widget.jobListings[index]
                                                      .companyName),
                                          memCacheWidth: 100,
                                          memCacheHeight: 100,
                                        )
                                      : _buildLogoPlaceholder(
                                          context,
                                          widget
                                              .jobListings[index].companyName),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Job Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.jobListings[index].companyName ??
                                          '',
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.jobListings[index].position ?? '',
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    if (widget.jobListings[index].keywords !=
                                        null)
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: widget
                                            .jobListings[index].keywords!
                                            .map((keyword) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: isDark
                                                  ? theme.colorScheme
                                                      .surfaceVariant
                                                  : theme.colorScheme.surface,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: theme.colorScheme.outline
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                            child: Text(
                                              keyword,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color:
                                                    theme.colorScheme.onSurface,
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
                      if (_buildStatusButtons(widget.jobListings[index].id)
                          .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _buildStatusButtons(
                                widget.jobListings[index].id),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
