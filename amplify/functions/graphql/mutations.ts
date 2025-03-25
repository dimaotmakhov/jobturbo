/* tslint:disable */
/* eslint-disable */
// this is an auto generated file. This will be overwritten

import * as APITypes from "./API";
type GeneratedMutation<InputType, OutputType> = string & {
  __generatedMutationInput: InputType;
  __generatedMutationOutput: OutputType;
};

export const createJobListing = /* GraphQL */ `mutation CreateJobListing(
  $condition: ModelJobListingConditionInput
  $input: CreateJobListingInput!
) {
  createJobListing(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.CreateJobListingMutationVariables,
  APITypes.CreateJobListingMutation
>;
export const createRequest = /* GraphQL */ `mutation CreateRequest(
  $condition: ModelRequestConditionInput
  $input: CreateRequestInput!
) {
  createRequest(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.CreateRequestMutationVariables,
  APITypes.CreateRequestMutation
>;
export const createSetting = /* GraphQL */ `mutation CreateSetting(
  $condition: ModelSettingConditionInput
  $input: CreateSettingInput!
) {
  createSetting(condition: $condition, input: $input) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedMutation<
  APITypes.CreateSettingMutationVariables,
  APITypes.CreateSettingMutation
>;
export const deleteJobListing = /* GraphQL */ `mutation DeleteJobListing(
  $condition: ModelJobListingConditionInput
  $input: DeleteJobListingInput!
) {
  deleteJobListing(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.DeleteJobListingMutationVariables,
  APITypes.DeleteJobListingMutation
>;
export const deleteRequest = /* GraphQL */ `mutation DeleteRequest(
  $condition: ModelRequestConditionInput
  $input: DeleteRequestInput!
) {
  deleteRequest(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.DeleteRequestMutationVariables,
  APITypes.DeleteRequestMutation
>;
export const deleteSetting = /* GraphQL */ `mutation DeleteSetting(
  $condition: ModelSettingConditionInput
  $input: DeleteSettingInput!
) {
  deleteSetting(condition: $condition, input: $input) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedMutation<
  APITypes.DeleteSettingMutationVariables,
  APITypes.DeleteSettingMutation
>;
export const jobListingMutation = /* GraphQL */ `mutation JobListingMutation($id: String) {
  jobListingMutation(id: $id) {
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
` as GeneratedMutation<
  APITypes.JobListingMutationMutationVariables,
  APITypes.JobListingMutationMutation
>;
export const updateJobListing = /* GraphQL */ `mutation UpdateJobListing(
  $condition: ModelJobListingConditionInput
  $input: UpdateJobListingInput!
) {
  updateJobListing(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.UpdateJobListingMutationVariables,
  APITypes.UpdateJobListingMutation
>;
export const updateRequest = /* GraphQL */ `mutation UpdateRequest(
  $condition: ModelRequestConditionInput
  $input: UpdateRequestInput!
) {
  updateRequest(condition: $condition, input: $input) {
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
` as GeneratedMutation<
  APITypes.UpdateRequestMutationVariables,
  APITypes.UpdateRequestMutation
>;
export const updateSetting = /* GraphQL */ `mutation UpdateSetting(
  $condition: ModelSettingConditionInput
  $input: UpdateSettingInput!
) {
  updateSetting(condition: $condition, input: $input) {
    createdAt
    deviceToken
    deviceTokens
    id
    owner
    updatedAt
    __typename
  }
}
` as GeneratedMutation<
  APITypes.UpdateSettingMutationVariables,
  APITypes.UpdateSettingMutation
>;
