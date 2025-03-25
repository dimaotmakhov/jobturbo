import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:jobturbo/models/Request.dart';

class RequestScreenMock {
  static List<Request> getMockRequests() {
    return [
      Request(
        createdAt: TemporalDateTime.now(),
        updatedAt: TemporalDateTime.now(),
        sortKey: "sortKey",
        country: 'us',
        location: 'San Francisco, CA',
        position: 'Senior Software Engineer',
        keywords: ['Flutter', 'Mobile Development', 'iOS'],
        repeat: ['mo', 'we', 'fr'],
      ),
      Request(
        createdAt: TemporalDateTime.now(),
        updatedAt: TemporalDateTime.now(),
        sortKey: "sortKey",
        country: 'de',
        location: 'Berlin',
        position: 'Product Manager',
        keywords: ['Tech', 'Startup', 'Product Strategy'],
        repeat: ['tu', 'th'],
      ),
    ];
  }

  static Future<GraphQLResponse<String>> mockList() async {
    final mockRequestsJson =
        getMockRequests().map((request) => request.toJson()).toList();

    return GraphQLResponse(
      data: json.encode({
        'listRequestBySortKeyAndCreatedAt': {
          'items': mockRequestsJson,
          'nextToken': null,
          '__typename': 'ModelRequestConnection'
        }
      }),
      errors: <GraphQLResponseError>[],
    );
  }
}
