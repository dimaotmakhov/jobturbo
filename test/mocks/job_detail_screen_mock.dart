import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:jobturbo/models/JobListing.dart';
import 'package:jobturbo/models/JobListingStatus.dart';

class JobDetailScreenMock {
  static JobListing mockJob = JobListing(
    id: 'mock-job-1',
    sortKey: 'mock-job-1',
    companyName: 'Tech Corp',
    position: 'Senior Software Engineer',
    jobPreview:
        'We are looking for a talented Senior Software Engineer to join our dynamic team. The ideal candidate will have strong experience in full-stack development, cloud technologies, and agile methodologies.',
    logo: 'https://example.com/logo.png',
    keywords: ['Flutter', 'AWS', 'GraphQL', 'TypeScript'],
    isApplied: false,
    status: JobListingStatus.NO_ANSWER,
    createdAt: TemporalDateTime.fromString('2024-01-01T00:00:00.000Z'),
    updatedAt: TemporalDateTime.fromString('2024-01-01T00:00:00.000Z'),
    isViewed: false,
  );
}
