/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the JobListing type in your schema. */
class JobListing extends amplify_core.Model {
  static const classType = const _JobListingModelType();
  final String id;
  final String? _owner;
  final String? _hash;
  final String? _sortKey;
  final String? _companyName;
  final String? _jobPreview;
  final String? _position;
  final String? _logo;
  final String? _url;
  final List<String>? _keywords;
  final bool? _isApplied;
  final JobListingStatus? _status;
  final List<String>? _links;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final bool? _isViewed;
  final Request? _request;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  JobListingModelIdentifier get modelIdentifier {
      return JobListingModelIdentifier(
        id: id
      );
  }
  
  String? get owner {
    return _owner;
  }
  
  String? get hash {
    return _hash;
  }
  
  String get sortKey {
    try {
      return _sortKey!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get companyName {
    return _companyName;
  }
  
  String? get jobPreview {
    return _jobPreview;
  }
  
  String? get position {
    return _position;
  }
  
  String? get logo {
    return _logo;
  }
  
  String? get url {
    return _url;
  }
  
  List<String>? get keywords {
    return _keywords;
  }
  
  bool? get isApplied {
    return _isApplied;
  }
  
  JobListingStatus? get status {
    return _status;
  }
  
  List<String>? get links {
    return _links;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  bool? get isViewed {
    return _isViewed;
  }
  
  Request? get request {
    return _request;
  }
  
  const JobListing._internal({required this.id, owner, hash, required sortKey, companyName, jobPreview, position, logo, url, keywords, isApplied, status, links, createdAt, updatedAt, isViewed, request}): _owner = owner, _hash = hash, _sortKey = sortKey, _companyName = companyName, _jobPreview = jobPreview, _position = position, _logo = logo, _url = url, _keywords = keywords, _isApplied = isApplied, _status = status, _links = links, _createdAt = createdAt, _updatedAt = updatedAt, _isViewed = isViewed, _request = request;
  
  factory JobListing({String? id, String? owner, String? hash, required String sortKey, String? companyName, String? jobPreview, String? position, String? logo, String? url, List<String>? keywords, bool? isApplied, JobListingStatus? status, List<String>? links, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, bool? isViewed, Request? request}) {
    return JobListing._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      owner: owner,
      hash: hash,
      sortKey: sortKey,
      companyName: companyName,
      jobPreview: jobPreview,
      position: position,
      logo: logo,
      url: url,
      keywords: keywords != null ? List<String>.unmodifiable(keywords) : keywords,
      isApplied: isApplied,
      status: status,
      links: links != null ? List<String>.unmodifiable(links) : links,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isViewed: isViewed,
      request: request);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobListing &&
      id == other.id &&
      _owner == other._owner &&
      _hash == other._hash &&
      _sortKey == other._sortKey &&
      _companyName == other._companyName &&
      _jobPreview == other._jobPreview &&
      _position == other._position &&
      _logo == other._logo &&
      _url == other._url &&
      DeepCollectionEquality().equals(_keywords, other._keywords) &&
      _isApplied == other._isApplied &&
      _status == other._status &&
      DeepCollectionEquality().equals(_links, other._links) &&
      _createdAt == other._createdAt &&
      _updatedAt == other._updatedAt &&
      _isViewed == other._isViewed &&
      _request == other._request;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("JobListing {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("hash=" + "$_hash" + ", ");
    buffer.write("sortKey=" + "$_sortKey" + ", ");
    buffer.write("companyName=" + "$_companyName" + ", ");
    buffer.write("jobPreview=" + "$_jobPreview" + ", ");
    buffer.write("position=" + "$_position" + ", ");
    buffer.write("logo=" + "$_logo" + ", ");
    buffer.write("url=" + "$_url" + ", ");
    buffer.write("keywords=" + (_keywords != null ? _keywords!.toString() : "null") + ", ");
    buffer.write("isApplied=" + (_isApplied != null ? _isApplied!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? amplify_core.enumToString(_status)! : "null") + ", ");
    buffer.write("links=" + (_links != null ? _links!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("isViewed=" + (_isViewed != null ? _isViewed!.toString() : "null") + ", ");
    buffer.write("request=" + (_request != null ? _request!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  JobListing copyWith({String? owner, String? hash, String? sortKey, String? companyName, String? jobPreview, String? position, String? logo, String? url, List<String>? keywords, bool? isApplied, JobListingStatus? status, List<String>? links, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, bool? isViewed, Request? request}) {
    return JobListing._internal(
      id: id,
      owner: owner ?? this.owner,
      hash: hash ?? this.hash,
      sortKey: sortKey ?? this.sortKey,
      companyName: companyName ?? this.companyName,
      jobPreview: jobPreview ?? this.jobPreview,
      position: position ?? this.position,
      logo: logo ?? this.logo,
      url: url ?? this.url,
      keywords: keywords ?? this.keywords,
      isApplied: isApplied ?? this.isApplied,
      status: status ?? this.status,
      links: links ?? this.links,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isViewed: isViewed ?? this.isViewed,
      request: request ?? this.request);
  }
  
  JobListing copyWithModelFieldValues({
    ModelFieldValue<String?>? owner,
    ModelFieldValue<String?>? hash,
    ModelFieldValue<String>? sortKey,
    ModelFieldValue<String?>? companyName,
    ModelFieldValue<String?>? jobPreview,
    ModelFieldValue<String?>? position,
    ModelFieldValue<String?>? logo,
    ModelFieldValue<String?>? url,
    ModelFieldValue<List<String>?>? keywords,
    ModelFieldValue<bool?>? isApplied,
    ModelFieldValue<JobListingStatus?>? status,
    ModelFieldValue<List<String>?>? links,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdAt,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedAt,
    ModelFieldValue<bool?>? isViewed,
    ModelFieldValue<Request?>? request
  }) {
    return JobListing._internal(
      id: id,
      owner: owner == null ? this.owner : owner.value,
      hash: hash == null ? this.hash : hash.value,
      sortKey: sortKey == null ? this.sortKey : sortKey.value,
      companyName: companyName == null ? this.companyName : companyName.value,
      jobPreview: jobPreview == null ? this.jobPreview : jobPreview.value,
      position: position == null ? this.position : position.value,
      logo: logo == null ? this.logo : logo.value,
      url: url == null ? this.url : url.value,
      keywords: keywords == null ? this.keywords : keywords.value,
      isApplied: isApplied == null ? this.isApplied : isApplied.value,
      status: status == null ? this.status : status.value,
      links: links == null ? this.links : links.value,
      createdAt: createdAt == null ? this.createdAt : createdAt.value,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt.value,
      isViewed: isViewed == null ? this.isViewed : isViewed.value,
      request: request == null ? this.request : request.value
    );
  }
  
  JobListing.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _owner = json['owner'],
      _hash = json['hash'],
      _sortKey = json['sortKey'],
      _companyName = json['companyName'],
      _jobPreview = json['jobPreview'],
      _position = json['position'],
      _logo = json['logo'],
      _url = json['url'],
      _keywords = json['keywords']?.cast<String>(),
      _isApplied = json['isApplied'],
      _status = amplify_core.enumFromString<JobListingStatus>(json['status'], JobListingStatus.values),
      _links = json['links']?.cast<String>(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _isViewed = json['isViewed'],
      _request = json['request'] != null
        ? json['request']['serializedData'] != null
          ? Request.fromJson(new Map<String, dynamic>.from(json['request']['serializedData']))
          : Request.fromJson(new Map<String, dynamic>.from(json['request']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'owner': _owner, 'hash': _hash, 'sortKey': _sortKey, 'companyName': _companyName, 'jobPreview': _jobPreview, 'position': _position, 'logo': _logo, 'url': _url, 'keywords': _keywords, 'isApplied': _isApplied, 'status': amplify_core.enumToString(_status), 'links': _links, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'isViewed': _isViewed, 'request': _request?.toJson()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'owner': _owner,
    'hash': _hash,
    'sortKey': _sortKey,
    'companyName': _companyName,
    'jobPreview': _jobPreview,
    'position': _position,
    'logo': _logo,
    'url': _url,
    'keywords': _keywords,
    'isApplied': _isApplied,
    'status': _status,
    'links': _links,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'isViewed': _isViewed,
    'request': _request
  };

  static final amplify_core.QueryModelIdentifier<JobListingModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<JobListingModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final HASH = amplify_core.QueryField(fieldName: "hash");
  static final SORTKEY = amplify_core.QueryField(fieldName: "sortKey");
  static final COMPANYNAME = amplify_core.QueryField(fieldName: "companyName");
  static final JOBPREVIEW = amplify_core.QueryField(fieldName: "jobPreview");
  static final POSITION = amplify_core.QueryField(fieldName: "position");
  static final LOGO = amplify_core.QueryField(fieldName: "logo");
  static final URL = amplify_core.QueryField(fieldName: "url");
  static final KEYWORDS = amplify_core.QueryField(fieldName: "keywords");
  static final ISAPPLIED = amplify_core.QueryField(fieldName: "isApplied");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static final LINKS = amplify_core.QueryField(fieldName: "links");
  static final CREATEDAT = amplify_core.QueryField(fieldName: "createdAt");
  static final UPDATEDAT = amplify_core.QueryField(fieldName: "updatedAt");
  static final ISVIEWED = amplify_core.QueryField(fieldName: "isViewed");
  static final REQUEST = amplify_core.QueryField(
    fieldName: "request",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Request'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "JobListing";
    modelSchemaDefinition.pluralName = "JobListings";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["owner", "createdAt"], name: "jobListingsByOwnerAndCreatedAt"),
      amplify_core.ModelIndex(fields: const ["hash"], name: "jobListingsByHash"),
      amplify_core.ModelIndex(fields: const ["sortKey", "createdAt"], name: "jobListingsBySortKeyAndCreatedAt"),
      amplify_core.ModelIndex(fields: const ["status", "createdAt"], name: "jobListingsByStatusAndCreatedAt")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.HASH,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.SORTKEY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.COMPANYNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.JOBPREVIEW,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.POSITION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.LOGO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.URL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.KEYWORDS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.ISAPPLIED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.STATUS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.LINKS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.CREATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.UPDATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobListing.ISVIEWED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: JobListing.REQUEST,
      isRequired: false,
      targetNames: ['requestId'],
      ofModelName: 'Request'
    ));
  });
}

class _JobListingModelType extends amplify_core.ModelType<JobListing> {
  const _JobListingModelType();
  
  @override
  JobListing fromJson(Map<String, dynamic> jsonData) {
    return JobListing.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'JobListing';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [JobListing] in your schema.
 */
class JobListingModelIdentifier implements amplify_core.ModelIdentifier<JobListing> {
  final String id;

  /** Create an instance of JobListingModelIdentifier using [id] the primary key. */
  const JobListingModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'JobListingModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is JobListingModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}