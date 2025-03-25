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


/** This is an auto generated class representing the JobLink type in your schema. */
class JobLink extends amplify_core.Model {
  static const classType = const _JobLinkModelType();
  final String id;
  final String? _websiteName;
  final String? _url;
  final String? _logoUrl;
  final bool? _isCompanyWebsite;
  final JobListing? _joblisting;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _owner;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  JobLinkModelIdentifier get modelIdentifier {
      return JobLinkModelIdentifier(
        id: id
      );
  }
  
  String? get websiteName {
    return _websiteName;
  }
  
  String? get url {
    return _url;
  }
  
  String? get logoUrl {
    return _logoUrl;
  }
  
  bool? get isCompanyWebsite {
    return _isCompanyWebsite;
  }
  
  JobListing? get joblisting {
    return _joblisting;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get owner {
    return _owner;
  }
  
  const JobLink._internal({required this.id, websiteName, url, logoUrl, isCompanyWebsite, joblisting, createdAt, updatedAt, owner}): _websiteName = websiteName, _url = url, _logoUrl = logoUrl, _isCompanyWebsite = isCompanyWebsite, _joblisting = joblisting, _createdAt = createdAt, _updatedAt = updatedAt, _owner = owner;
  
  factory JobLink({String? id, String? websiteName, String? url, String? logoUrl, bool? isCompanyWebsite, JobListing? joblisting, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, String? owner}) {
    return JobLink._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      websiteName: websiteName,
      url: url,
      logoUrl: logoUrl,
      isCompanyWebsite: isCompanyWebsite,
      joblisting: joblisting,
      createdAt: createdAt,
      updatedAt: updatedAt,
      owner: owner);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is JobLink &&
      id == other.id &&
      _websiteName == other._websiteName &&
      _url == other._url &&
      _logoUrl == other._logoUrl &&
      _isCompanyWebsite == other._isCompanyWebsite &&
      _joblisting == other._joblisting &&
      _createdAt == other._createdAt &&
      _updatedAt == other._updatedAt &&
      _owner == other._owner;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("JobLink {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("websiteName=" + "$_websiteName" + ", ");
    buffer.write("url=" + "$_url" + ", ");
    buffer.write("logoUrl=" + "$_logoUrl" + ", ");
    buffer.write("isCompanyWebsite=" + (_isCompanyWebsite != null ? _isCompanyWebsite!.toString() : "null") + ", ");
    buffer.write("joblisting=" + (_joblisting != null ? _joblisting!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("owner=" + "$_owner");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  JobLink copyWith({String? websiteName, String? url, String? logoUrl, bool? isCompanyWebsite, JobListing? joblisting, amplify_core.TemporalDateTime? createdAt, amplify_core.TemporalDateTime? updatedAt, String? owner}) {
    return JobLink._internal(
      id: id,
      websiteName: websiteName ?? this.websiteName,
      url: url ?? this.url,
      logoUrl: logoUrl ?? this.logoUrl,
      isCompanyWebsite: isCompanyWebsite ?? this.isCompanyWebsite,
      joblisting: joblisting ?? this.joblisting,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      owner: owner ?? this.owner);
  }
  
  JobLink copyWithModelFieldValues({
    ModelFieldValue<String?>? websiteName,
    ModelFieldValue<String?>? url,
    ModelFieldValue<String?>? logoUrl,
    ModelFieldValue<bool?>? isCompanyWebsite,
    ModelFieldValue<JobListing?>? joblisting,
    ModelFieldValue<amplify_core.TemporalDateTime?>? createdAt,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedAt,
    ModelFieldValue<String?>? owner
  }) {
    return JobLink._internal(
      id: id,
      websiteName: websiteName == null ? this.websiteName : websiteName.value,
      url: url == null ? this.url : url.value,
      logoUrl: logoUrl == null ? this.logoUrl : logoUrl.value,
      isCompanyWebsite: isCompanyWebsite == null ? this.isCompanyWebsite : isCompanyWebsite.value,
      joblisting: joblisting == null ? this.joblisting : joblisting.value,
      createdAt: createdAt == null ? this.createdAt : createdAt.value,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt.value,
      owner: owner == null ? this.owner : owner.value
    );
  }
  
  JobLink.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _websiteName = json['websiteName'],
      _url = json['url'],
      _logoUrl = json['logoUrl'],
      _isCompanyWebsite = json['isCompanyWebsite'],
      _joblisting = json['joblisting'] != null
        ? json['joblisting']['serializedData'] != null
          ? JobListing.fromJson(new Map<String, dynamic>.from(json['joblisting']['serializedData']))
          : JobListing.fromJson(new Map<String, dynamic>.from(json['joblisting']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _owner = json['owner'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'websiteName': _websiteName, 'url': _url, 'logoUrl': _logoUrl, 'isCompanyWebsite': _isCompanyWebsite, 'joblisting': _joblisting?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'owner': _owner
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'websiteName': _websiteName,
    'url': _url,
    'logoUrl': _logoUrl,
    'isCompanyWebsite': _isCompanyWebsite,
    'joblisting': _joblisting,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'owner': _owner
  };

  static final amplify_core.QueryModelIdentifier<JobLinkModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<JobLinkModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final WEBSITENAME = amplify_core.QueryField(fieldName: "websiteName");
  static final URL = amplify_core.QueryField(fieldName: "url");
  static final LOGOURL = amplify_core.QueryField(fieldName: "logoUrl");
  static final ISCOMPANYWEBSITE = amplify_core.QueryField(fieldName: "isCompanyWebsite");
  static final JOBLISTING = amplify_core.QueryField(
    fieldName: "joblisting",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'JobListing'));
  static final CREATEDAT = amplify_core.QueryField(fieldName: "createdAt");
  static final UPDATEDAT = amplify_core.QueryField(fieldName: "updatedAt");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "JobLink";
    modelSchemaDefinition.pluralName = "JobLinks";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.WEBSITENAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.URL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.LOGOURL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.ISCOMPANYWEBSITE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: JobLink.JOBLISTING,
      isRequired: false,
      targetNames: ['jobListingLinksId'],
      ofModelName: 'JobListing'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.CREATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.UPDATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: JobLink.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _JobLinkModelType extends amplify_core.ModelType<JobLink> {
  const _JobLinkModelType();
  
  @override
  JobLink fromJson(Map<String, dynamic> jsonData) {
    return JobLink.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'JobLink';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [JobLink] in your schema.
 */
class JobLinkModelIdentifier implements amplify_core.ModelIdentifier<JobLink> {
  final String id;

  /** Create an instance of JobLinkModelIdentifier using [id] the primary key. */
  const JobLinkModelIdentifier({
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
  String toString() => 'JobLinkModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is JobLinkModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}