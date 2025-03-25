const amplifyConfig = '''{
  "auth": {
    "user_pool_id": "us-east-1_22jKIwaTG",
    "aws_region": "us-east-1",
    "user_pool_client_id": "3o39kb3ffmvk72jltk5ga7nl1f",
    "identity_pool_id": "us-east-1:c8d30851-8dca-418c-b93d-d58ce05f0e2b",
    "mfa_methods": [],
    "standard_required_attributes": [
      "email"
    ],
    "username_attributes": [
      "email"
    ],
    "user_verification_types": [
      "email"
    ],
    "groups": [],
    "mfa_configuration": "NONE",
    "password_policy": {
      "min_length": 8,
      "require_lowercase": true,
      "require_numbers": true,
      "require_symbols": true,
      "require_uppercase": true
    },
    "oauth": {
      "identity_providers": [
        "GOOGLE"
      ],
      "redirect_sign_in_uri": [
        "http://localhost:8080/",
        "jobturbo://"
      ],
      "redirect_sign_out_uri": [
        "http://localhost:8080/",
        "jobturbo://"
      ],
      "response_type": "code",
      "scopes": [
        "phone",
        "email",
        "openid",
        "profile",
        "aws.cognito.signin.user.admin"
      ],
      "domain": "a9f5ca7aacf0bdbb17c3.auth.us-east-1.amazoncognito.com"
    },
    "unauthenticated_identities_enabled": true
  },
  "data": {
    "url": "https://oz2iux7zvfh65dp75wztc4mlly.appsync-api.us-east-1.amazonaws.com/graphql",
    "aws_region": "us-east-1",
    "default_authorization_type": "AMAZON_COGNITO_USER_POOLS",
    "authorization_types": [
      "AWS_IAM"
    ],
    "model_introspection": {
      "version": 1,
      "models": {
        "Setting": {
          "name": "Setting",
          "fields": {
            "id": {
              "name": "id",
              "isArray": false,
              "type": "ID",
              "isRequired": true,
              "attributes": []
            },
            "owner": {
              "name": "owner",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "deviceToken": {
              "name": "deviceToken",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "deviceTokens": {
              "name": "deviceTokens",
              "isArray": true,
              "type": "String",
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true
            },
            "createdAt": {
              "name": "createdAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": [],
              "isReadOnly": true
            },
            "updatedAt": {
              "name": "updatedAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": [],
              "isReadOnly": true
            }
          },
          "syncable": true,
          "pluralName": "Settings",
          "attributes": [
            {
              "type": "model",
              "properties": {}
            },
            {
              "type": "key",
              "properties": {
                "fields": [
                  "id"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "settingsByOwner",
                "queryField": "listSettingByOwner",
                "fields": [
                  "owner"
                ]
              }
            },
            {
              "type": "auth",
              "properties": {
                "rules": [
                  {
                    "provider": "userPools",
                    "ownerField": "owner",
                    "allow": "owner",
                    "operations": [
                      "create",
                      "update",
                      "get",
                      "list"
                    ],
                    "identityClaim": "cognito:username"
                  }
                ]
              }
            }
          ],
          "primaryKeyInfo": {
            "isCustomPrimaryKey": false,
            "primaryKeyFieldName": "id",
            "sortKeyFieldNames": []
          }
        },
        "Request": {
          "name": "Request",
          "fields": {
            "id": {
              "name": "id",
              "isArray": false,
              "type": "ID",
              "isRequired": true,
              "attributes": []
            },
            "owner": {
              "name": "owner",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "sortKey": {
              "name": "sortKey",
              "isArray": false,
              "type": "String",
              "isRequired": true,
              "attributes": []
            },
            "country": {
              "name": "country",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "location": {
              "name": "location",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "position": {
              "name": "position",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "keywords": {
              "name": "keywords",
              "isArray": true,
              "type": "String",
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true
            },
            "repeat": {
              "name": "repeat",
              "isArray": true,
              "type": "String",
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true
            },
            "status": {
              "name": "status",
              "isArray": false,
              "type": {
                "enum": "RequestStatus"
              },
              "isRequired": false,
              "attributes": []
            },
            "lastRun": {
              "name": "lastRun",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": []
            },
            "createdAt": {
              "name": "createdAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": []
            },
            "updatedAt": {
              "name": "updatedAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": []
            },
            "jobListings": {
              "name": "jobListings",
              "isArray": true,
              "type": {
                "model": "JobListing"
              },
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true,
              "association": {
                "connectionType": "HAS_MANY",
                "associatedWith": [
                  "requestId"
                ]
              }
            }
          },
          "syncable": true,
          "pluralName": "Requests",
          "attributes": [
            {
              "type": "model",
              "properties": {}
            },
            {
              "type": "key",
              "properties": {
                "fields": [
                  "id"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "requestsByOwnerAndCreatedAt",
                "queryField": "listRequestByOwnerAndCreatedAt",
                "fields": [
                  "owner",
                  "createdAt"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "requestsBySortKeyAndCreatedAt",
                "queryField": "listRequestBySortKeyAndCreatedAt",
                "fields": [
                  "sortKey",
                  "createdAt"
                ]
              }
            },
            {
              "type": "auth",
              "properties": {
                "rules": [
                  {
                    "provider": "userPools",
                    "ownerField": "owner",
                    "allow": "owner",
                    "operations": [
                      "create",
                      "update",
                      "delete",
                      "get",
                      "list"
                    ],
                    "identityClaim": "cognito:username"
                  }
                ]
              }
            }
          ],
          "primaryKeyInfo": {
            "isCustomPrimaryKey": false,
            "primaryKeyFieldName": "id",
            "sortKeyFieldNames": []
          }
        },
        "JobListing": {
          "name": "JobListing",
          "fields": {
            "id": {
              "name": "id",
              "isArray": false,
              "type": "ID",
              "isRequired": true,
              "attributes": []
            },
            "owner": {
              "name": "owner",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "hash": {
              "name": "hash",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "sortKey": {
              "name": "sortKey",
              "isArray": false,
              "type": "String",
              "isRequired": true,
              "attributes": []
            },
            "companyName": {
              "name": "companyName",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "jobPreview": {
              "name": "jobPreview",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "position": {
              "name": "position",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "logo": {
              "name": "logo",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "url": {
              "name": "url",
              "isArray": false,
              "type": "String",
              "isRequired": false,
              "attributes": []
            },
            "keywords": {
              "name": "keywords",
              "isArray": true,
              "type": "String",
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true
            },
            "isApplied": {
              "name": "isApplied",
              "isArray": false,
              "type": "Boolean",
              "isRequired": false,
              "attributes": []
            },
            "status": {
              "name": "status",
              "isArray": false,
              "type": {
                "enum": "JobListingStatus"
              },
              "isRequired": false,
              "attributes": []
            },
            "links": {
              "name": "links",
              "isArray": true,
              "type": "AWSJSON",
              "isRequired": false,
              "attributes": [],
              "isArrayNullable": true
            },
            "createdAt": {
              "name": "createdAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": []
            },
            "updatedAt": {
              "name": "updatedAt",
              "isArray": false,
              "type": "AWSDateTime",
              "isRequired": false,
              "attributes": []
            },
            "isViewed": {
              "name": "isViewed",
              "isArray": false,
              "type": "Boolean",
              "isRequired": false,
              "attributes": []
            },
            "requestId": {
              "name": "requestId",
              "isArray": false,
              "type": "ID",
              "isRequired": false,
              "attributes": []
            },
            "request": {
              "name": "request",
              "isArray": false,
              "type": {
                "model": "Request"
              },
              "isRequired": false,
              "attributes": [],
              "association": {
                "connectionType": "BELONGS_TO",
                "targetNames": [
                  "requestId"
                ]
              }
            }
          },
          "syncable": true,
          "pluralName": "JobListings",
          "attributes": [
            {
              "type": "model",
              "properties": {}
            },
            {
              "type": "key",
              "properties": {
                "fields": [
                  "id"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "jobListingsByOwnerAndCreatedAt",
                "queryField": "listJobListingByOwnerAndCreatedAt",
                "fields": [
                  "owner",
                  "createdAt"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "jobListingsByHash",
                "queryField": "listJobListingByHash",
                "fields": [
                  "hash"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "jobListingsBySortKeyAndCreatedAt",
                "queryField": "listJobListingBySortKeyAndCreatedAt",
                "fields": [
                  "sortKey",
                  "createdAt"
                ]
              }
            },
            {
              "type": "key",
              "properties": {
                "name": "jobListingsByStatusAndCreatedAt",
                "queryField": "listJobListingByStatusAndCreatedAt",
                "fields": [
                  "status",
                  "createdAt"
                ]
              }
            },
            {
              "type": "auth",
              "properties": {
                "rules": [
                  {
                    "provider": "userPools",
                    "ownerField": "owner",
                    "allow": "owner",
                    "identityClaim": "cognito:username",
                    "operations": [
                      "create",
                      "update",
                      "delete",
                      "read"
                    ]
                  }
                ]
              }
            }
          ],
          "primaryKeyInfo": {
            "isCustomPrimaryKey": false,
            "primaryKeyFieldName": "id",
            "sortKeyFieldNames": []
          }
        }
      },
      "enums": {
        "RequestStatus": {
          "name": "RequestStatus",
          "values": [
            "RUN",
            "STOP"
          ]
        },
        "JobListingStatus": {
          "name": "JobListingStatus",
          "values": [
            "APPLIED",
            "NO_ANSWER",
            "REJECTED",
            "SUCCESSFUL"
          ]
        }
      },
      "nonModels": {},
      "mutations": {
        "jobListingMutation": {
          "name": "jobListingMutation",
          "isArray": false,
          "type": {
            "model": "JobListing"
          },
          "isRequired": false,
          "arguments": {
            "id": {
              "name": "id",
              "isArray": false,
              "type": "String",
              "isRequired": false
            }
          }
        }
      }
    }
  },
  "version": "1.3",
  "notifications": {
    "amazon_pinpoint_app_id": "5ca6fe86299b4dc78ea3aee72095133e",
    "aws_region": "us-east-1",
    "channels": [
      "APNS"
    ]
  }
}''';