/* tslint:disable */
/* eslint-disable */
//  This file was automatically generated and should not be edited.

export type JobListing = {
  __typename: "JobListing",
  companyName?: string | null,
  createdAt?: string | null,
  hash?: string | null,
  id: string,
  isApplied?: boolean | null,
  isViewed?: boolean | null,
  jobPreview?: string | null,
  keywords?: Array< string | null > | null,
  links?: Array< string | null > | null,
  logo?: string | null,
  owner?: string | null,
  position?: string | null,
  request?: Request | null,
  requestId?: string | null,
  sortKey: string,
  status?: JobListingStatus | null,
  updatedAt?: string | null,
  url?: string | null,
};

export type Request = {
  __typename: "Request",
  country?: string | null,
  createdAt?: string | null,
  id: string,
  jobListings?: ModelJobListingConnection | null,
  keywords?: Array< string | null > | null,
  lastRun?: string | null,
  location?: string | null,
  owner?: string | null,
  position?: string | null,
  repeat?: Array< string | null > | null,
  sortKey: string,
  status?: RequestStatus | null,
  updatedAt?: string | null,
};

export type ModelJobListingConnection = {
  __typename: "ModelJobListingConnection",
  items:  Array<JobListing | null >,
  nextToken?: string | null,
};

export enum RequestStatus {
  RUN = "RUN",
  STOP = "STOP",
}


export enum JobListingStatus {
  APPLIED = "APPLIED",
  NO_ANSWER = "NO_ANSWER",
  REJECTED = "REJECTED",
  SUCCESSFUL = "SUCCESSFUL",
}


export type Setting = {
  __typename: "Setting",
  createdAt: string,
  deviceToken?: string | null,
  deviceTokens?: Array< string | null > | null,
  id: string,
  owner?: string | null,
  updatedAt: string,
};

export type ModelJobListingFilterInput = {
  and?: Array< ModelJobListingFilterInput | null > | null,
  companyName?: ModelStringInput | null,
  createdAt?: ModelStringInput | null,
  hash?: ModelStringInput | null,
  id?: ModelIDInput | null,
  isApplied?: ModelBooleanInput | null,
  isViewed?: ModelBooleanInput | null,
  jobPreview?: ModelStringInput | null,
  keywords?: ModelStringInput | null,
  links?: ModelStringInput | null,
  logo?: ModelStringInput | null,
  not?: ModelJobListingFilterInput | null,
  or?: Array< ModelJobListingFilterInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelStringInput | null,
  requestId?: ModelIDInput | null,
  sortKey?: ModelStringInput | null,
  status?: ModelJobListingStatusInput | null,
  updatedAt?: ModelStringInput | null,
  url?: ModelStringInput | null,
};

export type ModelStringInput = {
  attributeExists?: boolean | null,
  attributeType?: ModelAttributeTypes | null,
  beginsWith?: string | null,
  between?: Array< string | null > | null,
  contains?: string | null,
  eq?: string | null,
  ge?: string | null,
  gt?: string | null,
  le?: string | null,
  lt?: string | null,
  ne?: string | null,
  notContains?: string | null,
  size?: ModelSizeInput | null,
};

export enum ModelAttributeTypes {
  _null = "_null",
  binary = "binary",
  binarySet = "binarySet",
  bool = "bool",
  list = "list",
  map = "map",
  number = "number",
  numberSet = "numberSet",
  string = "string",
  stringSet = "stringSet",
}


export type ModelSizeInput = {
  between?: Array< number | null > | null,
  eq?: number | null,
  ge?: number | null,
  gt?: number | null,
  le?: number | null,
  lt?: number | null,
  ne?: number | null,
};

export type ModelIDInput = {
  attributeExists?: boolean | null,
  attributeType?: ModelAttributeTypes | null,
  beginsWith?: string | null,
  between?: Array< string | null > | null,
  contains?: string | null,
  eq?: string | null,
  ge?: string | null,
  gt?: string | null,
  le?: string | null,
  lt?: string | null,
  ne?: string | null,
  notContains?: string | null,
  size?: ModelSizeInput | null,
};

export type ModelBooleanInput = {
  attributeExists?: boolean | null,
  attributeType?: ModelAttributeTypes | null,
  eq?: boolean | null,
  ne?: boolean | null,
};

export type ModelJobListingStatusInput = {
  eq?: JobListingStatus | null,
  ne?: JobListingStatus | null,
};

export enum ModelSortDirection {
  ASC = "ASC",
  DESC = "DESC",
}


export type ModelStringKeyConditionInput = {
  beginsWith?: string | null,
  between?: Array< string | null > | null,
  eq?: string | null,
  ge?: string | null,
  gt?: string | null,
  le?: string | null,
  lt?: string | null,
};

export type ModelRequestFilterInput = {
  and?: Array< ModelRequestFilterInput | null > | null,
  country?: ModelStringInput | null,
  createdAt?: ModelStringInput | null,
  id?: ModelIDInput | null,
  keywords?: ModelStringInput | null,
  lastRun?: ModelStringInput | null,
  location?: ModelStringInput | null,
  not?: ModelRequestFilterInput | null,
  or?: Array< ModelRequestFilterInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelStringInput | null,
  repeat?: ModelStringInput | null,
  sortKey?: ModelStringInput | null,
  status?: ModelRequestStatusInput | null,
  updatedAt?: ModelStringInput | null,
};

export type ModelRequestStatusInput = {
  eq?: RequestStatus | null,
  ne?: RequestStatus | null,
};

export type ModelRequestConnection = {
  __typename: "ModelRequestConnection",
  items:  Array<Request | null >,
  nextToken?: string | null,
};

export type ModelSettingFilterInput = {
  and?: Array< ModelSettingFilterInput | null > | null,
  createdAt?: ModelStringInput | null,
  deviceToken?: ModelStringInput | null,
  deviceTokens?: ModelStringInput | null,
  id?: ModelIDInput | null,
  not?: ModelSettingFilterInput | null,
  or?: Array< ModelSettingFilterInput | null > | null,
  owner?: ModelStringInput | null,
  updatedAt?: ModelStringInput | null,
};

export type ModelSettingConnection = {
  __typename: "ModelSettingConnection",
  items:  Array<Setting | null >,
  nextToken?: string | null,
};

export type ModelJobListingConditionInput = {
  and?: Array< ModelJobListingConditionInput | null > | null,
  companyName?: ModelStringInput | null,
  createdAt?: ModelStringInput | null,
  hash?: ModelStringInput | null,
  isApplied?: ModelBooleanInput | null,
  isViewed?: ModelBooleanInput | null,
  jobPreview?: ModelStringInput | null,
  keywords?: ModelStringInput | null,
  links?: ModelStringInput | null,
  logo?: ModelStringInput | null,
  not?: ModelJobListingConditionInput | null,
  or?: Array< ModelJobListingConditionInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelStringInput | null,
  requestId?: ModelIDInput | null,
  sortKey?: ModelStringInput | null,
  status?: ModelJobListingStatusInput | null,
  updatedAt?: ModelStringInput | null,
  url?: ModelStringInput | null,
};

export type CreateJobListingInput = {
  companyName?: string | null,
  createdAt?: string | null,
  hash?: string | null,
  id?: string | null,
  isApplied?: boolean | null,
  isViewed?: boolean | null,
  jobPreview?: string | null,
  keywords?: Array< string | null > | null,
  links?: Array< string | null > | null,
  logo?: string | null,
  owner?: string | null,
  position?: string | null,
  requestId?: string | null,
  sortKey: string,
  status?: JobListingStatus | null,
  updatedAt?: string | null,
  url?: string | null,
};

export type ModelRequestConditionInput = {
  and?: Array< ModelRequestConditionInput | null > | null,
  country?: ModelStringInput | null,
  createdAt?: ModelStringInput | null,
  keywords?: ModelStringInput | null,
  lastRun?: ModelStringInput | null,
  location?: ModelStringInput | null,
  not?: ModelRequestConditionInput | null,
  or?: Array< ModelRequestConditionInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelStringInput | null,
  repeat?: ModelStringInput | null,
  sortKey?: ModelStringInput | null,
  status?: ModelRequestStatusInput | null,
  updatedAt?: ModelStringInput | null,
};

export type CreateRequestInput = {
  country?: string | null,
  createdAt?: string | null,
  id?: string | null,
  keywords?: Array< string | null > | null,
  lastRun?: string | null,
  location?: string | null,
  owner?: string | null,
  position?: string | null,
  repeat?: Array< string | null > | null,
  sortKey: string,
  status?: RequestStatus | null,
  updatedAt?: string | null,
};

export type ModelSettingConditionInput = {
  and?: Array< ModelSettingConditionInput | null > | null,
  createdAt?: ModelStringInput | null,
  deviceToken?: ModelStringInput | null,
  deviceTokens?: ModelStringInput | null,
  not?: ModelSettingConditionInput | null,
  or?: Array< ModelSettingConditionInput | null > | null,
  owner?: ModelStringInput | null,
  updatedAt?: ModelStringInput | null,
};

export type CreateSettingInput = {
  deviceToken?: string | null,
  deviceTokens?: Array< string | null > | null,
  id?: string | null,
  owner?: string | null,
};

export type DeleteJobListingInput = {
  id: string,
};

export type DeleteRequestInput = {
  id: string,
};

export type DeleteSettingInput = {
  id: string,
};

export type UpdateJobListingInput = {
  companyName?: string | null,
  createdAt?: string | null,
  hash?: string | null,
  id: string,
  isApplied?: boolean | null,
  isViewed?: boolean | null,
  jobPreview?: string | null,
  keywords?: Array< string | null > | null,
  links?: Array< string | null > | null,
  logo?: string | null,
  owner?: string | null,
  position?: string | null,
  requestId?: string | null,
  sortKey?: string | null,
  status?: JobListingStatus | null,
  updatedAt?: string | null,
  url?: string | null,
};

export type UpdateRequestInput = {
  country?: string | null,
  createdAt?: string | null,
  id: string,
  keywords?: Array< string | null > | null,
  lastRun?: string | null,
  location?: string | null,
  owner?: string | null,
  position?: string | null,
  repeat?: Array< string | null > | null,
  sortKey?: string | null,
  status?: RequestStatus | null,
  updatedAt?: string | null,
};

export type UpdateSettingInput = {
  deviceToken?: string | null,
  deviceTokens?: Array< string | null > | null,
  id: string,
  owner?: string | null,
};

export type ModelSubscriptionJobListingFilterInput = {
  and?: Array< ModelSubscriptionJobListingFilterInput | null > | null,
  companyName?: ModelSubscriptionStringInput | null,
  createdAt?: ModelSubscriptionStringInput | null,
  hash?: ModelSubscriptionStringInput | null,
  id?: ModelSubscriptionIDInput | null,
  isApplied?: ModelSubscriptionBooleanInput | null,
  isViewed?: ModelSubscriptionBooleanInput | null,
  jobPreview?: ModelSubscriptionStringInput | null,
  keywords?: ModelSubscriptionStringInput | null,
  links?: ModelSubscriptionStringInput | null,
  logo?: ModelSubscriptionStringInput | null,
  or?: Array< ModelSubscriptionJobListingFilterInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelSubscriptionStringInput | null,
  requestId?: ModelSubscriptionIDInput | null,
  sortKey?: ModelSubscriptionStringInput | null,
  status?: ModelSubscriptionStringInput | null,
  updatedAt?: ModelSubscriptionStringInput | null,
  url?: ModelSubscriptionStringInput | null,
};

export type ModelSubscriptionStringInput = {
  beginsWith?: string | null,
  between?: Array< string | null > | null,
  contains?: string | null,
  eq?: string | null,
  ge?: string | null,
  gt?: string | null,
  in?: Array< string | null > | null,
  le?: string | null,
  lt?: string | null,
  ne?: string | null,
  notContains?: string | null,
  notIn?: Array< string | null > | null,
};

export type ModelSubscriptionIDInput = {
  beginsWith?: string | null,
  between?: Array< string | null > | null,
  contains?: string | null,
  eq?: string | null,
  ge?: string | null,
  gt?: string | null,
  in?: Array< string | null > | null,
  le?: string | null,
  lt?: string | null,
  ne?: string | null,
  notContains?: string | null,
  notIn?: Array< string | null > | null,
};

export type ModelSubscriptionBooleanInput = {
  eq?: boolean | null,
  ne?: boolean | null,
};

export type ModelSubscriptionRequestFilterInput = {
  and?: Array< ModelSubscriptionRequestFilterInput | null > | null,
  country?: ModelSubscriptionStringInput | null,
  createdAt?: ModelSubscriptionStringInput | null,
  id?: ModelSubscriptionIDInput | null,
  keywords?: ModelSubscriptionStringInput | null,
  lastRun?: ModelSubscriptionStringInput | null,
  location?: ModelSubscriptionStringInput | null,
  or?: Array< ModelSubscriptionRequestFilterInput | null > | null,
  owner?: ModelStringInput | null,
  position?: ModelSubscriptionStringInput | null,
  repeat?: ModelSubscriptionStringInput | null,
  sortKey?: ModelSubscriptionStringInput | null,
  status?: ModelSubscriptionStringInput | null,
  updatedAt?: ModelSubscriptionStringInput | null,
};

export type ModelSubscriptionSettingFilterInput = {
  and?: Array< ModelSubscriptionSettingFilterInput | null > | null,
  createdAt?: ModelSubscriptionStringInput | null,
  deviceToken?: ModelSubscriptionStringInput | null,
  deviceTokens?: ModelSubscriptionStringInput | null,
  id?: ModelSubscriptionIDInput | null,
  or?: Array< ModelSubscriptionSettingFilterInput | null > | null,
  owner?: ModelStringInput | null,
  updatedAt?: ModelSubscriptionStringInput | null,
};

export type GetJobListingQueryVariables = {
  id: string,
};

export type GetJobListingQuery = {
  getJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type GetRequestQueryVariables = {
  id: string,
};

export type GetRequestQuery = {
  getRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type GetSettingQueryVariables = {
  id: string,
};

export type GetSettingQuery = {
  getSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type ListJobListingByHashQueryVariables = {
  filter?: ModelJobListingFilterInput | null,
  hash: string,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListJobListingByHashQuery = {
  listJobListingByHash?:  {
    __typename: "ModelJobListingConnection",
    items:  Array< {
      __typename: "JobListing",
      companyName?: string | null,
      createdAt?: string | null,
      hash?: string | null,
      id: string,
      isApplied?: boolean | null,
      isViewed?: boolean | null,
      jobPreview?: string | null,
      keywords?: Array< string | null > | null,
      links?: Array< string | null > | null,
      logo?: string | null,
      owner?: string | null,
      position?: string | null,
      requestId?: string | null,
      sortKey: string,
      status?: JobListingStatus | null,
      updatedAt?: string | null,
      url?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListJobListingByOwnerAndCreatedAtQueryVariables = {
  createdAt?: ModelStringKeyConditionInput | null,
  filter?: ModelJobListingFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  owner: string,
  sortDirection?: ModelSortDirection | null,
};

export type ListJobListingByOwnerAndCreatedAtQuery = {
  listJobListingByOwnerAndCreatedAt?:  {
    __typename: "ModelJobListingConnection",
    items:  Array< {
      __typename: "JobListing",
      companyName?: string | null,
      createdAt?: string | null,
      hash?: string | null,
      id: string,
      isApplied?: boolean | null,
      isViewed?: boolean | null,
      jobPreview?: string | null,
      keywords?: Array< string | null > | null,
      links?: Array< string | null > | null,
      logo?: string | null,
      owner?: string | null,
      position?: string | null,
      requestId?: string | null,
      sortKey: string,
      status?: JobListingStatus | null,
      updatedAt?: string | null,
      url?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListJobListingBySortKeyAndCreatedAtQueryVariables = {
  createdAt?: ModelStringKeyConditionInput | null,
  filter?: ModelJobListingFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
  sortKey: string,
};

export type ListJobListingBySortKeyAndCreatedAtQuery = {
  listJobListingBySortKeyAndCreatedAt?:  {
    __typename: "ModelJobListingConnection",
    items:  Array< {
      __typename: "JobListing",
      companyName?: string | null,
      createdAt?: string | null,
      hash?: string | null,
      id: string,
      isApplied?: boolean | null,
      isViewed?: boolean | null,
      jobPreview?: string | null,
      keywords?: Array< string | null > | null,
      links?: Array< string | null > | null,
      logo?: string | null,
      owner?: string | null,
      position?: string | null,
      requestId?: string | null,
      sortKey: string,
      status?: JobListingStatus | null,
      updatedAt?: string | null,
      url?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListJobListingByStatusAndCreatedAtQueryVariables = {
  createdAt?: ModelStringKeyConditionInput | null,
  filter?: ModelJobListingFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
  status: JobListingStatus,
};

export type ListJobListingByStatusAndCreatedAtQuery = {
  listJobListingByStatusAndCreatedAt?:  {
    __typename: "ModelJobListingConnection",
    items:  Array< {
      __typename: "JobListing",
      companyName?: string | null,
      createdAt?: string | null,
      hash?: string | null,
      id: string,
      isApplied?: boolean | null,
      isViewed?: boolean | null,
      jobPreview?: string | null,
      keywords?: Array< string | null > | null,
      links?: Array< string | null > | null,
      logo?: string | null,
      owner?: string | null,
      position?: string | null,
      requestId?: string | null,
      sortKey: string,
      status?: JobListingStatus | null,
      updatedAt?: string | null,
      url?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListJobListingsQueryVariables = {
  filter?: ModelJobListingFilterInput | null,
  id?: string | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListJobListingsQuery = {
  listJobListings?:  {
    __typename: "ModelJobListingConnection",
    items:  Array< {
      __typename: "JobListing",
      companyName?: string | null,
      createdAt?: string | null,
      hash?: string | null,
      id: string,
      isApplied?: boolean | null,
      isViewed?: boolean | null,
      jobPreview?: string | null,
      keywords?: Array< string | null > | null,
      links?: Array< string | null > | null,
      logo?: string | null,
      owner?: string | null,
      position?: string | null,
      requestId?: string | null,
      sortKey: string,
      status?: JobListingStatus | null,
      updatedAt?: string | null,
      url?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListRequestByOwnerAndCreatedAtQueryVariables = {
  createdAt?: ModelStringKeyConditionInput | null,
  filter?: ModelRequestFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  owner: string,
  sortDirection?: ModelSortDirection | null,
};

export type ListRequestByOwnerAndCreatedAtQuery = {
  listRequestByOwnerAndCreatedAt?:  {
    __typename: "ModelRequestConnection",
    items:  Array< {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListRequestBySortKeyAndCreatedAtQueryVariables = {
  createdAt?: ModelStringKeyConditionInput | null,
  filter?: ModelRequestFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
  sortKey: string,
};

export type ListRequestBySortKeyAndCreatedAtQuery = {
  listRequestBySortKeyAndCreatedAt?:  {
    __typename: "ModelRequestConnection",
    items:  Array< {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListRequestsQueryVariables = {
  filter?: ModelRequestFilterInput | null,
  id?: string | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListRequestsQuery = {
  listRequests?:  {
    __typename: "ModelRequestConnection",
    items:  Array< {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListSettingByOwnerQueryVariables = {
  filter?: ModelSettingFilterInput | null,
  limit?: number | null,
  nextToken?: string | null,
  owner: string,
  sortDirection?: ModelSortDirection | null,
};

export type ListSettingByOwnerQuery = {
  listSettingByOwner?:  {
    __typename: "ModelSettingConnection",
    items:  Array< {
      __typename: "Setting",
      createdAt: string,
      deviceToken?: string | null,
      deviceTokens?: Array< string | null > | null,
      id: string,
      owner?: string | null,
      updatedAt: string,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type ListSettingsQueryVariables = {
  filter?: ModelSettingFilterInput | null,
  id?: string | null,
  limit?: number | null,
  nextToken?: string | null,
  sortDirection?: ModelSortDirection | null,
};

export type ListSettingsQuery = {
  listSettings?:  {
    __typename: "ModelSettingConnection",
    items:  Array< {
      __typename: "Setting",
      createdAt: string,
      deviceToken?: string | null,
      deviceTokens?: Array< string | null > | null,
      id: string,
      owner?: string | null,
      updatedAt: string,
    } | null >,
    nextToken?: string | null,
  } | null,
};

export type CreateJobListingMutationVariables = {
  condition?: ModelJobListingConditionInput | null,
  input: CreateJobListingInput,
};

export type CreateJobListingMutation = {
  createJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type CreateRequestMutationVariables = {
  condition?: ModelRequestConditionInput | null,
  input: CreateRequestInput,
};

export type CreateRequestMutation = {
  createRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type CreateSettingMutationVariables = {
  condition?: ModelSettingConditionInput | null,
  input: CreateSettingInput,
};

export type CreateSettingMutation = {
  createSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type DeleteJobListingMutationVariables = {
  condition?: ModelJobListingConditionInput | null,
  input: DeleteJobListingInput,
};

export type DeleteJobListingMutation = {
  deleteJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type DeleteRequestMutationVariables = {
  condition?: ModelRequestConditionInput | null,
  input: DeleteRequestInput,
};

export type DeleteRequestMutation = {
  deleteRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type DeleteSettingMutationVariables = {
  condition?: ModelSettingConditionInput | null,
  input: DeleteSettingInput,
};

export type DeleteSettingMutation = {
  deleteSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type JobListingMutationMutationVariables = {
  id?: string | null,
};

export type JobListingMutationMutation = {
  jobListingMutation?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type UpdateJobListingMutationVariables = {
  condition?: ModelJobListingConditionInput | null,
  input: UpdateJobListingInput,
};

export type UpdateJobListingMutation = {
  updateJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type UpdateRequestMutationVariables = {
  condition?: ModelRequestConditionInput | null,
  input: UpdateRequestInput,
};

export type UpdateRequestMutation = {
  updateRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type UpdateSettingMutationVariables = {
  condition?: ModelSettingConditionInput | null,
  input: UpdateSettingInput,
};

export type UpdateSettingMutation = {
  updateSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type OnCreateJobListingSubscriptionVariables = {
  filter?: ModelSubscriptionJobListingFilterInput | null,
  owner?: string | null,
};

export type OnCreateJobListingSubscription = {
  onCreateJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type OnCreateRequestSubscriptionVariables = {
  filter?: ModelSubscriptionRequestFilterInput | null,
  owner?: string | null,
};

export type OnCreateRequestSubscription = {
  onCreateRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type OnCreateSettingSubscriptionVariables = {
  filter?: ModelSubscriptionSettingFilterInput | null,
  owner?: string | null,
};

export type OnCreateSettingSubscription = {
  onCreateSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type OnDeleteJobListingSubscriptionVariables = {
  filter?: ModelSubscriptionJobListingFilterInput | null,
  owner?: string | null,
};

export type OnDeleteJobListingSubscription = {
  onDeleteJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type OnDeleteRequestSubscriptionVariables = {
  filter?: ModelSubscriptionRequestFilterInput | null,
  owner?: string | null,
};

export type OnDeleteRequestSubscription = {
  onDeleteRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type OnDeleteSettingSubscriptionVariables = {
  filter?: ModelSubscriptionSettingFilterInput | null,
  owner?: string | null,
};

export type OnDeleteSettingSubscription = {
  onDeleteSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};

export type OnUpdateJobListingSubscriptionVariables = {
  filter?: ModelSubscriptionJobListingFilterInput | null,
  owner?: string | null,
};

export type OnUpdateJobListingSubscription = {
  onUpdateJobListing?:  {
    __typename: "JobListing",
    companyName?: string | null,
    createdAt?: string | null,
    hash?: string | null,
    id: string,
    isApplied?: boolean | null,
    isViewed?: boolean | null,
    jobPreview?: string | null,
    keywords?: Array< string | null > | null,
    links?: Array< string | null > | null,
    logo?: string | null,
    owner?: string | null,
    position?: string | null,
    request?:  {
      __typename: "Request",
      country?: string | null,
      createdAt?: string | null,
      id: string,
      keywords?: Array< string | null > | null,
      lastRun?: string | null,
      location?: string | null,
      owner?: string | null,
      position?: string | null,
      repeat?: Array< string | null > | null,
      sortKey: string,
      status?: RequestStatus | null,
      updatedAt?: string | null,
    } | null,
    requestId?: string | null,
    sortKey: string,
    status?: JobListingStatus | null,
    updatedAt?: string | null,
    url?: string | null,
  } | null,
};

export type OnUpdateRequestSubscriptionVariables = {
  filter?: ModelSubscriptionRequestFilterInput | null,
  owner?: string | null,
};

export type OnUpdateRequestSubscription = {
  onUpdateRequest?:  {
    __typename: "Request",
    country?: string | null,
    createdAt?: string | null,
    id: string,
    jobListings?:  {
      __typename: "ModelJobListingConnection",
      nextToken?: string | null,
    } | null,
    keywords?: Array< string | null > | null,
    lastRun?: string | null,
    location?: string | null,
    owner?: string | null,
    position?: string | null,
    repeat?: Array< string | null > | null,
    sortKey: string,
    status?: RequestStatus | null,
    updatedAt?: string | null,
  } | null,
};

export type OnUpdateSettingSubscriptionVariables = {
  filter?: ModelSubscriptionSettingFilterInput | null,
  owner?: string | null,
};

export type OnUpdateSettingSubscription = {
  onUpdateSetting?:  {
    __typename: "Setting",
    createdAt: string,
    deviceToken?: string | null,
    deviceTokens?: Array< string | null > | null,
    id: string,
    owner?: string | null,
    updatedAt: string,
  } | null,
};
