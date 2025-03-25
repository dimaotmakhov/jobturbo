import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/JobListing.dart';
import 'job_list_screen.dart';
import 'dart:convert';
import '../l10n/app_localizations.dart';

class ProgressScreen extends StatefulWidget {
  final dynamic mockQueryProvider;

  const ProgressScreen({super.key, this.mockQueryProvider});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Map<String, List<JobListing>> _jobListingsByStatus = {
    'APPLIED': [],
    'NO_ANSWER': [],
    'REJECTED': [],
    'SUCCESSFUL': [],
  };

  String listJobListingsQuery = '''
query ListJobListingsByStatus(
  \$status: JobListingStatus!
  \$createdAt: ModelStringKeyConditionInput
  \$sortDirection: ModelSortDirection
  \$limit: Int
) {
  listJobListingByStatusAndCreatedAt(
    status: \$status
    createdAt: \$createdAt
    sortDirection: \$sortDirection
    limit: \$limit
  ) {
    items {
      id
      companyName
      position
      keywords
      isApplied
      status
      createdAt
      updatedAt
      logo
    }
    nextToken
  }
}
''';

  @override
  void initState() {
    super.initState();
    _refreshJobListings();
  }

  Future<void> _fetchJobListingsByStatus(String status) async {
    try {
      final request = GraphQLRequest<String>(
        document: listJobListingsQuery,
        variables: {
          'status': status,
          'limit': 500,
          'sortDirection': 'DESC',
        },
      );

      final response = widget.mockQueryProvider != null
          ? await widget.mockQueryProvider(status)
          : await Amplify.API.query(request: request).response;

      if (response.hasErrors) {
        safePrint('errors: ${response.errors}');
        return;
      }

      Map<String, dynamic> jsonMap = json.decode(response.data!);
      final jobListingsJson = jsonMap['listJobListingByStatusAndCreatedAt']
          ['items'] as List<dynamic>;

      setState(() {
        _jobListingsByStatus[status] =
            jobListingsJson.map((item) => JobListing.fromJson(item)).toList();
      });
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }

  Future<void> _refreshJobListings() async {
    await Future.wait([
      _fetchJobListingsByStatus('APPLIED'),
      _fetchJobListingsByStatus('NO_ANSWER'),
      _fetchJobListingsByStatus('REJECTED'),
      _fetchJobListingsByStatus('SUCCESSFUL'),
    ]);
  }

  Future<void> _navigateToJobList(
      BuildContext context, String title, String status) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JobListScreen(
          title: title,
          jobListings: _jobListingsByStatus[status] ?? [],
        ),
      ),
    );
    // Refresh the lists when returning from JobListScreen
    _refreshJobListings();
  }

  Widget _buildChart(AppLocalizations localizations) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: _jobListingsByStatus.values
                    .map((list) => list.length)
                    .reduce((a, b) => a > b ? a : b)
                    .toDouble() +
                1,
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    String text = '';
                    switch (value.toInt()) {
                      case 0:
                        text = localizations.appliedStatus;
                        break;
                      case 1:
                        text = localizations.noAnswerStatus;
                        break;
                      case 2:
                        text = localizations.rejectedStatus;
                        break;
                      case 3:
                        text = localizations.successfulStatus;
                        break;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        text,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    if (value == value.roundToDouble()) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.shade300),
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: (_jobListingsByStatus['APPLIED']?.length ?? 0)
                        .toDouble(),
                    color: Colors.blue,
                    width: 20,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: (_jobListingsByStatus['NO_ANSWER']?.length ?? 0)
                        .toDouble(),
                    color: Colors.orange,
                    width: 20,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: (_jobListingsByStatus['REJECTED']?.length ?? 0)
                        .toDouble(),
                    color: Colors.red,
                    width: 20,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: (_jobListingsByStatus['SUCCESSFUL']?.length ?? 0)
                        .toDouble(),
                    color: Colors.green,
                    width: 20,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshJobListings,
        child: ListView(
          children: [
            _buildChart(localizations),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85, // Adjusted to give more vertical space
              children: [
                _StatCard(
                  title: localizations.appliedStatus,
                  count: _jobListingsByStatus['APPLIED']?.length ?? 0,
                  icon: Icons.send,
                  color: Colors.blue,
                  onTap: () => _navigateToJobList(
                      context, localizations.appliedJobs, 'APPLIED'),
                ),
                _StatCard(
                  title: localizations.noAnswerStatus,
                  count: _jobListingsByStatus['NO_ANSWER']?.length ?? 0,
                  icon: Icons.hourglass_empty,
                  color: Colors.orange,
                  onTap: () => _navigateToJobList(
                      context, localizations.pendingJobs, 'NO_ANSWER'),
                ),
                _StatCard(
                  title: localizations.rejectedStatus,
                  count: _jobListingsByStatus['REJECTED']?.length ?? 0,
                  icon: Icons.cancel,
                  color: Colors.red,
                  onTap: () => _navigateToJobList(
                      context, localizations.rejectedJobs, 'REJECTED'),
                ),
                _StatCard(
                  title: localizations.successfulStatus,
                  count: _jobListingsByStatus['SUCCESSFUL']?.length ?? 0,
                  icon: Icons.check_circle,
                  color: Colors.green,
                  onTap: () => _navigateToJobList(context,
                      localizations.successfulApplications, 'SUCCESSFUL'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
