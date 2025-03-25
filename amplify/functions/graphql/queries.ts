/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";
type GeneratedQuery<InputType, OutputType> = string & {
  __generatedQueryInput: InputType;
  __generatedQueryOutput: OutputType;
};

export const getJobListing = /* GraphQL */ `query GetJobListing($id: ID!) {
  getJobListing(id: $id) {
    companyName
    createdAt
    hash
    id
    isApplied
    isViewed
    jobPreview
    keywords
    links
    logo
    owner
    position
    request {
      country
      createdAt
      id
      keywords
      lastRun
      location
      owner
      position
      repeat
      sortKey
      status
      updatedAt
      __typename
    }
    requestId
    sortKey
    status
    updatedAt
    url
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetJobListingQueryVariables,
  APITypes.GetJobListingQuery
>;
export const getRequest = /* GraphQL */ `query GetRequest($id: ID!) {
  getRequest(id: $id) {
    country
    createdAt
    id
    jobListings {
      nextToken
      __typename
    }
    keywords
    lastRun
    location
    owner
    position
    repeat
    sortKey
    status
    updatedAt
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetRequestQueryVariables,
  APITypes.GetRequestQuery
>;
export const getSetting = /* GraphQL */ `query GetSetting($id: ID!) {
  getSetting(id: $id) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedQuery<
  APITypes.GetSettingQueryVariables,
  APITypes.GetSettingQuery
>;
export const listJobListingByHash = /* GraphQL */ `query ListJobListingByHash(
  $filter: ModelJobListingFilterInput
  $hash: String!
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listJobListingByHash(
    filter: $filter
    hash: $hash
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      companyName
      createdAt
      hash
      id
      isApplied
      isViewed
      jobPreview
      keywords
      links
      logo
      owner
      position
      requestId
      sortKey
      status
      updatedAt
      url
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListJobListingByHashQueryVariables,
  APITypes.ListJobListingByHashQuery
>;
export const listJobListingByOwnerAndCreatedAt = /* GraphQL */ `query ListJobListingByOwnerAndCreatedAt(
  $createdAt: ModelStringKeyConditionInput
  $filter: ModelJobListingFilterInput
  $limit: Int
  $nextToken: String
  $owner: String!
  $sortDirection: ModelSortDirection
) {
  listJobListingByOwnerAndCreatedAt(
    createdAt: $createdAt
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    owner: $owner
    sortDirection: $sortDirection
  ) {
    items {
      companyName
      createdAt
      hash
      id
      isApplied
      isViewed
      jobPreview
      keywords
      links
      logo
      owner
      position
      requestId
      sortKey
      status
      updatedAt
      url
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListJobListingByOwnerAndCreatedAtQueryVariables,
  APITypes.ListJobListingByOwnerAndCreatedAtQuery
>;
export const listJobListingBySortKeyAndCreatedAt = /* GraphQL */ `query ListJobListingBySortKeyAndCreatedAt(
  $createdAt: ModelStringKeyConditionInput
  $filter: ModelJobListingFilterInput
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
  $sortKey: String!
) {
  listJobListingBySortKeyAndCreatedAt(
    createdAt: $createdAt
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
    sortKey: $sortKey
  ) {
    items {
      companyName
      createdAt
      hash
      id
      isApplied
      isViewed
      jobPreview
      keywords
      links
      logo
      owner
      position
      requestId
      sortKey
      status
      updatedAt
      url
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListJobListingBySortKeyAndCreatedAtQueryVariables,
  APITypes.ListJobListingBySortKeyAndCreatedAtQuery
>;
export const listJobListingByStatusAndCreatedAt = /* GraphQL */ `query ListJobListingByStatusAndCreatedAt(
  $createdAt: ModelStringKeyConditionInput
  $filter: ModelJobListingFilterInput
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
  $status: JobListingStatus!
) {
  listJobListingByStatusAndCreatedAt(
    createdAt: $createdAt
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
    status: $status
  ) {
    items {
      companyName
      createdAt
      hash
      id
      isApplied
      isViewed
      jobPreview
      keywords
      links
      logo
      owner
      position
      requestId
      sortKey
      status
      updatedAt
      url
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListJobListingByStatusAndCreatedAtQueryVariables,
  APITypes.ListJobListingByStatusAndCreatedAtQuery
>;
export const listJobListings = /* GraphQL */ `query ListJobListings(
  $filter: ModelJobListingFilterInput
  $id: ID
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listJobListings(
    filter: $filter
    id: $id
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      companyName
      createdAt
      hash
      id
      isApplied
      isViewed
      jobPreview
      keywords
      links
      logo
      owner
      position
      requestId
      sortKey
      status
      updatedAt
      url
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListJobListingsQueryVariables,
  APITypes.ListJobListingsQuery
>;
export const listRequestByOwnerAndCreatedAt = /* GraphQL */ `query ListRequestByOwnerAndCreatedAt(
  $createdAt: ModelStringKeyConditionInput
  $filter: ModelRequestFilterInput
  $limit: Int
  $nextToken: String
  $owner: String!
  $sortDirection: ModelSortDirection
) {
  listRequestByOwnerAndCreatedAt(
    createdAt: $createdAt
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    owner: $owner
    sortDirection: $sortDirection
  ) {
    items {
      country
      createdAt
      id
      keywords
      lastRun
      location
      owner
      position
      repeat
      sortKey
      status
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListRequestByOwnerAndCreatedAtQueryVariables,
  APITypes.ListRequestByOwnerAndCreatedAtQuery
>;
export const listRequestBySortKeyAndCreatedAt = /* GraphQL */ `query ListRequestBySortKeyAndCreatedAt(
  $createdAt: ModelStringKeyConditionInput
  $filter: ModelRequestFilterInput
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
  $sortKey: String!
) {
  listRequestBySortKeyAndCreatedAt(
    createdAt: $createdAt
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
    sortKey: $sortKey
  ) {
    items {
      country
      createdAt
      id
      keywords
      lastRun
      location
      owner
      position
      repeat
      sortKey
      status
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListRequestBySortKeyAndCreatedAtQueryVariables,
  APITypes.ListRequestBySortKeyAndCreatedAtQuery
>;
export const listRequests = /* GraphQL */ `query ListRequests(
  $filter: ModelRequestFilterInput
  $id: ID
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listRequests(
    filter: $filter
    id: $id
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      country
      createdAt
      id
      keywords
      lastRun
      location
      owner
      position
      repeat
      sortKey
      status
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListRequestsQueryVariables,
  APITypes.ListRequestsQuery
>;
export const listSettingByOwner = /* GraphQL */ `query ListSettingByOwner(
  $filter: ModelSettingFilterInput
  $limit: Int
  $nextToken: String
  $owner: String!
  $sortDirection: ModelSortDirection
) {
  listSettingByOwner(
    filter: $filter
    limit: $limit
    nextToken: $nextToken
    owner: $owner
    sortDirection: $sortDirection
  ) {
    items {
      createdAt
      deviceToken
      deviceTokens
      id
      owner
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListSettingByOwnerQueryVariables,
  APITypes.ListSettingByOwnerQuery
>;
export const listSettings = /* GraphQL */ `query ListSettings(
  $filter: ModelSettingFilterInput
  $id: ID
  $limit: Int
  $nextToken: String
  $sortDirection: ModelSortDirection
) {
  listSettings(
    filter: $filter
    id: $id
    limit: $limit
    nextToken: $nextToken
    sortDirection: $sortDirection
  ) {
    items {
      createdAt
      deviceToken
      deviceTokens
      id
      owner
      updatedAt
      __typename
    }
    nextToken
    __typename
  }
}
` as GeneratedQuery<
  APITypes.ListSettingsQueryVariables,
  APITypes.ListSettingsQuery
>;
