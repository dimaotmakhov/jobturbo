import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:jobturbo/models/JobListing.dart';
import 'package:jobturbo/models/JobListingStatus.dart';

class ApplyScreenMock {
  static List<JobListing> getMockJobListings() {
    return [
      JobListing(
        id: '1',
        companyName: 'Tech Corp',
        position: 'Senior Flutter Developer',
        logo: null,
        keywords: ['Flutter', 'Dart', 'Mobile'],
        isApplied: false,
        status: JobListingStatus.NO_ANSWER,
        isViewed: false,
        createdAt: TemporalDateTime.now(),
        updatedAt: TemporalDateTime.now(),
        sortKey: 'sortKey',
      ),
      JobListing(
        id: '2',
        companyName: 'Startup Inc',
        position: 'Mobile Engineer',
        logo: null,
        keywords: ['iOS', 'Android', 'React Native'],
        isApplied: true,
        status: JobListingStatus.APPLIED,
        isViewed: true,
        createdAt: TemporalDateTime.now(),
        updatedAt: TemporalDateTime.now(),
        sortKey: 'sortKey',
      ),
      JobListing(
        id: '3',
        companyName: 'Software Co',
        position: 'Full Stack Developer',
        logo: null,
        keywords: ['JavaScript', 'Node.js', 'React'],
        isApplied: false,
        status: JobListingStatus.NO_ANSWER,
        isViewed: true,
        createdAt: TemporalDateTime.now(),
        updatedAt: TemporalDateTime.now(),
        sortKey: 'sortKey',
      ),
    ];
  }

  static Future<GraphQLResponse<String>> mockList() async {
    final mockListingsJson =
        getMockJobListings().map((listing) => listing.toJson()).toList();

    return GraphQLResponse(
      data: json.encode({
        'listJobListingBySortKeyAndCreatedAt': {
          'items': mockListingsJson,
          'nextToken': null,
          '__typename': 'ModelJobListingConnection'
        }
      }),
      errors: <GraphQLResponseError>[],
    );
  }
}
