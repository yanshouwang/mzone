// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'octo_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OctoTree _$OctoTreeFromJson(Map<String, dynamic> json) {
  return OctoTree(
    json['sha'] as String?,
    json['url'] as String?,
    (json['tree'] as List<dynamic>?)
        ?.map((e) => OctoNode.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['truncated'] as bool?,
    json['message'] as String?,
    json['documentation_url'] as String?,
  );
}

Map<String, dynamic> _$OctoTreeToJson(OctoTree instance) => <String, dynamic>{
      'sha': instance.sha,
      'url': instance.url,
      'tree': instance.nodes,
      'truncated': instance.truncated,
      'message': instance.message,
      'documentation_url': instance.documentationUrl,
    };
