// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String?,
      email: json['email'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      role: $enumDecodeNullable(_$RolesEnumMap, json['role']),
      createAt: json['createAt'] as int?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'role': _$RolesEnumMap[instance.role],
      'createAt': instance.createAt,
    };

const _$RolesEnumMap = {
  Roles.USER: 'USER',
  Roles.ADMIN: 'ADMIN',
};
