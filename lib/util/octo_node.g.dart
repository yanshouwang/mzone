// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'octo_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OctoNode _$OctoNodeFromJson(Map<String, dynamic> json) {
  return OctoNode(
    json['path'] as String,
    json['mode'] as String,
    json['type'] as String,
    json['sha'] as String,
    json['size'] as int?,
    json['url'] as String,
  );
}

Map<String, dynamic> _$OctoNodeToJson(OctoNode instance) => <String, dynamic>{
      'path': instance.path,
      'mode': instance.mode,
      'type': instance.type,
      'sha': instance.sha,
      'size': instance.size,
      'url': instance.url,
    };
