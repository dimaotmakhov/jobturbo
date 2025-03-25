class JobListing {
  final String id;
  final String companyName;
  final String companyDescription;
  final String position;
  final String logoUrl;
  final List<String> keywords;
  final bool isApplied;
  final List<JobLink> links;

  JobListing({
    required this.id,
    required this.companyName,
    required this.companyDescription,
    required this.position,
    required this.logoUrl,
    required this.keywords,
    required this.isApplied,
    required this.links,
  });
}

class JobLink {
  final String websiteName;
  final String url;
  final String logoUrl;

  JobLink({
    required this.websiteName,
    required this.url,
    required this.logoUrl,
  });
}
