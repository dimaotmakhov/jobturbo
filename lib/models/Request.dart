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


/** This is an auto generated class representing the Request type in your schema. */
class Request extends amplify_core.Model {
  static const classType = const _RequestModelType();
  final String id;
  final String? _owner;
  final String? _sortKey;
  final String? _country;
  final String? _location;
  final String? _position;
  final List<String>? _keywords;
  final List<String>? _repeat;
  final RequestStatus? _status;
  final amplify_core.TemporalDateTime? _lastRun;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final List<JobListing>? _jobListings;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  RequestModelIdentifier get modelIdentifier {
      return RequestModelIdentifier(
        id: id
      );
  }
  
  String? get owner {
    return _owner;
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
  
  String? get country {
    return _country;
  }
  
  String? get location {
    return _location;
  }
  
  String? get position {
    return _position;
  }
  
  List<String>? get keywords {
    return _keywords;
  }
  
  List<String>? get repeat {
    return _repeat;
  }
  
  RequestStatus? get status {
    return _status;
  }
  
  amplify_core.TemporalDateTime? get lastRun {
    return _lastRun;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  List<JobListing>? get jobListings {
    return _jobListings;
  }
  
  const Request._internal({required this.id, owner, required sortKey, country, location, position, keywords, repeat, status, lastRun, createdAt, updatedAt, jobListings}): _owner = owner, _sortKey = sortKey, _country = country, _location = location, _position = position, _keywords = keywords, _repeat = repeat, _status = status, _lastRun = lastRun, _createdAt = createdAt, _updatedAt = updatedAt, _jobListings = jobListings;
  
  factory Request({String? id, String? owner, required String sortKey, String? country, String? location, String? position, List<String>? keywords, List<String>? repeat, RequestStatus? status, amplify_core.TemporalDateTime? lastRun, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, List<JobListing>? jobListings}) {
    return Request._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      owner: owner,
      sortKey: sortKey,
      country: country,
      location: location,
      position: position,
      keywords: keywords != null ? List<String>.unmodifiable(keywords) : keywords,
      repeat: repeat != null ? List<String>.unmodifiable(repeat) : repeat,
      status: status,
      lastRun: lastRun,
      createdAt: createdAt,
      updatedAt: updatedAt,
      jobListings: jobListings != null ? List<JobListing>.unmodifiable(jobListings) : jobListings);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Request &&
      id == other.id &&
      _owner == other._owner &&
      _sortKey == other._sortKey &&
      _country == other._country &&
      _location == other._location &&
      _position == other._position &&
      DeepCollectionEquality().equals(_keywords, other._keywords) &&
      DeepCollectionEquality().equals(_repeat, other._repeat) &&
      _status == other._status &&
      _lastRun == other._lastRun &&
      _createdAt == other._createdAt &&
      _updatedAt == other._updatedAt &&
      DeepCollectionEquality().equals(_jobListings, other._jobListings);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Request {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("sortKey=" + "$_sortKey" + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("location=" + "$_location" + ", ");
    buffer.write("position=" + "$_position" + ", ");
    buffer.write("keywords=" + (_keywords != null ? _keywords!.toString() : "null") + ", ");
    buffer.write("repeat=" + (_repeat != null ? _repeat!.toString() : "null") + ", ");
    buffer.write("status=" + (_status != null ? amplify_core.enumToString(_status)! : "null") + ", ");
    buffer.write("lastRun=" + (_lastRun != null ? _lastRun!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Request copyWith({String? owner, String? sortKey, String? country, String? location, String? position, List<String>? keywords, List<String>? repeat, RequestStatus? status, amplify_core.TemporalDateTime? lastRun, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, List<JobListing>? jobListings}) {
    return Request._internal(
      id: id,
      owner: owner ?? this.owner,
      sortKey: sortKey ?? this.sortKey,
      country: country ?? this.country,
      location: location ?? this.location,
      position: position ?? this.position,
      keywords: keywords ?? this.keywords,
      repeat: repeat ?? this.repeat,
      status: status ?? this.status,
      lastRun: lastRun ?? this.lastRun,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      jobListings: jobListings ?? this.jobListings);
  }
  
  Request copyWithModelFieldValues({
    ModelFieldValue<String?>? owner,
    ModelFieldValue<String>? sortKey,
    ModelFieldValue<String?>? country,
    ModelFieldValue<String?>? location,
    ModelFieldValue<String?>? position,
    ModelFieldValue<List<String>?>? keywords,
    ModelFieldValue<List<String>?>? repeat,
    ModelFieldValue<RequestStatus?>? status,
    ModelFieldValue<amplify_core.TemporalDateTime?>? lastRun,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdAt,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedAt,
    ModelFieldValue<List<JobListing>?>? jobListings
  }) {
    return Request._internal(
      id: id,
      owner: owner == null ? this.owner : owner.value,
      sortKey: sortKey == null ? this.sortKey : sortKey.value,
      country: country == null ? this.country : country.value,
      location: location == null ? this.location : location.value,
      position: position == null ? this.position : position.value,
      keywords: keywords == null ? this.keywords : keywords.value,
      repeat: repeat == null ? this.repeat : repeat.value,
      status: status == null ? this.status : status.value,
      lastRun: lastRun == null ? this.lastRun : lastRun.value,
      createdAt: createdAt == null ? this.createdAt : createdAt.value,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt.value,
      jobListings: jobListings == null ? this.jobListings : jobListings.value
    );
  }
  
  Request.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _owner = json['owner'],
      _sortKey = json['sortKey'],
      _country = json['country'],
      _location = json['location'],
      _position = json['position'],
      _keywords = json['keywords']?.cast<String>(),
      _repeat = json['repeat']?.cast<String>(),
      _status = amplify_core.enumFromString<RequestStatus>(json['status'], RequestStatus.values),
      _lastRun = json['lastRun'] != null ? amplify_core.TemporalDateTime.fromString(json['lastRun']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _jobListings = json['jobListings']  is Map
        ? (json['jobListings']['items'] is List
          ? (json['jobListings']['items'] as List)
              .where((e) => e != null)
              .map((e) => JobListing.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['jobListings'] is List
          ? (json['jobListings'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => JobListing.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null);
  
  Map<String, dynamic> toJson() => {
    'id': id, 'owner': _owner, 'sortKey': _sortKey, 'country': _country, 'location': _location, 'position': _position, 'keywords': _keywords, 'repeat': _repeat, 'status': amplify_core.enumToString(_status), 'lastRun': _lastRun?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'jobListings': _jobListings?.map((JobListing? e) => e?.toJson()).toList()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'owner': _owner,
    'sortKey': _sortKey,
    'country': _country,
    'location': _location,
    'position': _position,
    'keywords': _keywords,
    'repeat': _repeat,
    'status': _status,
    'lastRun': _lastRun,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'jobListings': _jobListings
  };

  static final amplify_core.QueryModelIdentifier<RequestModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<RequestModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final SORTKEY = amplify_core.QueryField(fieldName: "sortKey");
  static final COUNTRY = amplify_core.QueryField(fieldName: "country");
  static final LOCATION = amplify_core.QueryField(fieldName: "location");
  static final POSITION = amplify_core.QueryField(fieldName: "position");
  static final KEYWORDS = amplify_core.QueryField(fieldName: "keywords");
  static final REPEAT = amplify_core.QueryField(fieldName: "repeat");
  static final STATUS = amplify_core.QueryField(fieldName: "status");
  static final LASTRUN = amplify_core.QueryField(fieldName: "lastRun");
  static final CREATEDAT = amplify_core.QueryField(fieldName: "createdAt");
  static final UPDATEDAT = amplify_core.QueryField(fieldName: "updatedAt");
  static final JOBLISTINGS = amplify_core.QueryField(
    fieldName: "jobListings",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'JobListing'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Request";
    modelSchemaDefinition.pluralName = "Requests";
    
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
          amplify_core.ModelOperation.GET,
          amplify_core.ModelOperation.LIST
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["id"], name: null),
      amplify_core.ModelIndex(fields: const ["owner", "createdAt"], name: "requestsByOwnerAndCreatedAt"),
      amplify_core.ModelIndex(fields: const ["sortKey", "createdAt"], name: "requestsBySortKeyAndCreatedAt")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.SORTKEY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.COUNTRY,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.LOCATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.POSITION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.KEYWORDS,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.REPEAT,
      isRequired: false,
      isArray: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.collection, ofModelName: amplify_core.ModelFieldTypeEnum.string.name)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.STATUS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.LASTRUN,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.CREATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Request.UPDATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Request.JOBLISTINGS,
      isRequired: false,
      ofModelName: 'JobListing',
      associatedKey: JobListing.REQUEST
    ));
  });
}

class _RequestModelType extends amplify_core.ModelType<Request> {
  const _RequestModelType();
  
  @override
  Request fromJson(Map<String, dynamic> jsonData) {
    return Request.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Request';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Request] in your schema.
 */
class RequestModelIdentifier implements amplify_core.ModelIdentifier<Request> {
  final String id;

  /** Create an instance of RequestModelIdentifier using [id] the primary key. */
  const RequestModelIdentifier({
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
  String toString() => 'RequestModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is RequestModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}