/*
* 2021年Amazon.com、Inc.またはその関連会社によるすべての権利が保護されています。
*
* Apache License、Version 2.0（「ライセンス」）に基づいてライセンスが授与されています。
* ライセンスに従っていない場合は、このファイルを使用できません。
* ライセンスのコピーは、
*
*  http://aws.amazon.com/apache2.0
*
* またはこのファイルに添付された「license」ファイルにあります。このファイルは
* "AS IS" BASISで配布されており、明示または暗示を問わず、いかなる保証もありません。
* ライセンスの詳細については、ライセンスを参照してください。
*/

// 注意: このファイルは生成されたものであり、アプリで定義されたリントのルールに従うとは限りません。
// 生成されたファイルは、analysis_options.yamlで分析から除外できます。
// 詳細については、https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis を参照してください。

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** これは、スキーマ内の Comments 型を表す自動生成されたクラスです。 */
class Comments extends amplify_core.Model {
  static const classType = const _CommentsModelType();
  final String id;
  final String? _username;
  final String? _message;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CommentsModelIdentifier get modelIdentifier {
      return CommentsModelIdentifier(
        id: id
      );
  }
  
  String? get username {
    return _username;
  }
  
  String? get message {
    return _message;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Comments._internal({required this.id, username, message, createdAt, updatedAt}): _username = username, _message = message, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Comments({String? id, String? username, String? message}) {
    return Comments._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      username: username,
      message: message);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comments &&
      id == other.id &&
      _username == other._username &&
      _message == other._message;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comments {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("message=" + "$_message" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comments copyWith({String? username, String? message}) {
    return Comments._internal(
      id: id,
      username: username ?? this.username,
      message: message ?? this.message);
  }
  
  Comments copyWithModelFieldValues({
    ModelFieldValue<String?>? username,
    ModelFieldValue<String?>? message
  }) {
    return Comments._internal(
      id: id,
      username: username == null ? this.username : username.value,
      message: message == null ? this.message : message.value
    );
  }
  
  Comments.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _message = json['message'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'message': _message, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'username': _username,
    'message': _message,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<CommentsModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CommentsModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final USERNAME = amplify_core.QueryField(fieldName: "username");
  static final MESSAGE = amplify_core.QueryField(fieldName: "message");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comments";
    modelSchemaDefinition.pluralName = "Comments";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.USERNAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.MESSAGE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _CommentsModelType extends amplify_core.ModelType<Comments> {
  const _CommentsModelType();
  
  @override
  Comments fromJson(Map<String, dynamic> jsonData) {
    return Comments.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Comments';
  }
}

/**
 * これは、スキーマ内の [Comments] のモデル識別子を表す自動生成されたクラスです。
 */
class CommentsModelIdentifier implements amplify_core.ModelIdentifier<Comments> {
  final String id;

  /** 主キーを使用して CommentsModelIdentifier のインスタンスを作成します。 */
  const CommentsModelIdentifier({
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
  String toString() => 'CommentsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CommentsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}