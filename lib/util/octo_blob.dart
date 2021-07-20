import 'package:json_annotation/json_annotation.dart';

part 'octo_blob.g.dart';

@JsonSerializable()
class OctoBlob {
  final String content;
  final String encoding;
  final String url;
  final String sha;
  final int size;
  @JsonKey(name: 'node_id')
  final String nodeId;

  OctoBlob(
    this.content,
    this.encoding,
    this.url,
    this.sha,
    this.size,
    this.nodeId,
  );

  factory OctoBlob.fromJson(Map<String, dynamic> json) =>
      _$OctoBlobFromJson(json);

  Map<String, dynamic> toJson() => _$OctoBlobToJson(this);
}
