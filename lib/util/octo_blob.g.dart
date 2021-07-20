// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'octo_blob.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OctoBlob _$OctoBlobFromJson(Map<String, dynamic> json) {
  return OctoBlob(
    json['content'] as String,
    json['encoding'] as String,
    json['url'] as String,
    json['sha'] as String,
    json['size'] as int,
    json['node_id'] as String,
  );
}

Map<String, dynamic> _$OctoBlobToJson(OctoBlob instance) => <String, dynamic>{
      'content': instance.content,
      'encoding': instance.encoding,
      'url': instance.url,
      'sha': instance.sha,
      'size': instance.size,
      'node_id': instance.nodeId,
    };
