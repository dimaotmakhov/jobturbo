/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";
type GeneratedSubscription<InputType, OutputType> = string & {
  __generatedSubscriptionInput: InputType;
  __generatedSubscriptionOutput: OutputType;
};

export const onCreateJobListing = /* GraphQL */ `subscription OnCreateJobListing(
  $filter: ModelSubscriptionJobListingFilterInput
  $owner: String
) {
  onCreateJobListing(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnCreateJobListingSubscriptionVariables,
  APITypes.OnCreateJobListingSubscription
>;
export const onCreateRequest = /* GraphQL */ `subscription OnCreateRequest(
  $filter: ModelSubscriptionRequestFilterInput
  $owner: String
) {
  onCreateRequest(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnCreateRequestSubscriptionVariables,
  APITypes.OnCreateRequestSubscription
>;
export const onCreateSetting = /* GraphQL */ `subscription OnCreateSetting(
  $filter: ModelSubscriptionSettingFilterInput
  $owner: String
) {
  onCreateSetting(filter: $filter, owner: $owner) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnCreateSettingSubscriptionVariables,
  APITypes.OnCreateSettingSubscription
>;
export const onDeleteJobListing = /* GraphQL */ `subscription OnDeleteJobListing(
  $filter: ModelSubscriptionJobListingFilterInput
  $owner: String
) {
  onDeleteJobListing(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnDeleteJobListingSubscriptionVariables,
  APITypes.OnDeleteJobListingSubscription
>;
export const onDeleteRequest = /* GraphQL */ `subscription OnDeleteRequest(
  $filter: ModelSubscriptionRequestFilterInput
  $owner: String
) {
  onDeleteRequest(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnDeleteRequestSubscriptionVariables,
  APITypes.OnDeleteRequestSubscription
>;
export const onDeleteSetting = /* GraphQL */ `subscription OnDeleteSetting(
  $filter: ModelSubscriptionSettingFilterInput
  $owner: String
) {
  onDeleteSetting(filter: $filter, owner: $owner) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnDeleteSettingSubscriptionVariables,
  APITypes.OnDeleteSettingSubscription
>;
export const onUpdateJobListing = /* GraphQL */ `subscription OnUpdateJobListing(
  $filter: ModelSubscriptionJobListingFilterInput
  $owner: String
) {
  onUpdateJobListing(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnUpdateJobListingSubscriptionVariables,
  APITypes.OnUpdateJobListingSubscription
>;
export const onUpdateRequest = /* GraphQL */ `subscription OnUpdateRequest(
  $filter: ModelSubscriptionRequestFilterInput
  $owner: String
) {
  onUpdateRequest(filter: $filter, owner: $owner) {
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
` as GeneratedSubscription<
  APITypes.OnUpdateRequestSubscriptionVariables,
  APITypes.OnUpdateRequestSubscription
>;
export const onUpdateSetting = /* GraphQL */ `subscription OnUpdateSetting(
  $filter: ModelSubscriptionSettingFilterInput
  $owner: String
) {
  onUpdateSetting(filter: $filter, owner: $owner) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedSubscription<
  APITypes.OnUpdateSettingSubscriptionVariables,
  APITypes.OnUpdateSettingSubscription
>;
