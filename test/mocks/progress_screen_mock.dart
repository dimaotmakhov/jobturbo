import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:jobturbo/models/JobListing.dart';
import 'package:jobturbo/models/JobListingStatus.dart';

class ProgressScreenMock {
  static List<JobListing> getMockJobListings(String status) {
    final now = TemporalDateTime.now();

    switch (status) {
      case 'APPLIED':
        return [
          JobListing(
            id: '1',
            companyName: 'Tech Corp',
            position: 'Senior Flutter Developer',
            logo: null,
            keywords: ['Flutter', 'Dart', 'Mobile'],
            isApplied: true,
            status: JobListingStatus.APPLIED,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
          JobListing(
            id: '2',
            companyName: 'Mobile Inc',
            position: 'Mobile Developer',
            logo: null,
            keywords: ['iOS', 'Android', 'Flutter'],
            isApplied: true,
            status: JobListingStatus.APPLIED,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
        ];

      case 'NO_ANSWER':
        return [
          JobListing(
            id: '3',
            companyName: 'Software Co',
            position: 'Full Stack Developer',
            logo: null,
            keywords: ['JavaScript', 'Node.js', 'React'],
            isApplied: true,
            status: JobListingStatus.NO_ANSWER,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
        ];

      case 'REJECTED':
        return [
          JobListing(
            id: '4',
            companyName: 'Dev Corp',
            position: 'Frontend Developer',
            logo: null,
            keywords: ['React', 'TypeScript', 'CSS'],
            isApplied: true,
            status: JobListingStatus.REJECTED,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
          JobListing(
            id: '5',
            companyName: 'Tech Solutions',
            position: 'React Developer',
            logo: null,
            keywords: ['React', 'JavaScript', 'HTML'],
            isApplied: true,
            status: JobListingStatus.REJECTED,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
        ];

      case 'SUCCESSFUL':
        return [
          JobListing(
            id: '6',
            companyName: 'Dream Tech',
            position: 'Senior Mobile Developer',
            logo: null,
            keywords: ['Flutter', 'Dart', 'Firebase'],
            isApplied: true,
            status: JobListingStatus.SUCCESSFUL,
            isViewed: true,
            createdAt: now,
            updatedAt: now,
            sortKey: 'sortKey',
          ),
        ];

      default:
        return [];
    }
  }

  static Future<GraphQLResponse<String>> mockListByStatus(String status) async {
    final mockListingsJson =
        getMockJobListings(status).map((listing) => listing.toJson()).toList();

    return GraphQLResponse(
      data: json.encode({
        'listJobListingByStatusAndCreatedAt': {
          'items': mockListingsJson,
          'nextToken': null,
          '__typename': 'ModelJobListingConnection'
        }
      }),
      errors: <GraphQLResponseError>[],
    );
  }
}
