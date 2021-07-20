import 'package:json_annotation/json_annotation.dart';

part 'octo_node.g.dart';

@JsonSerializable()
class OctoNode {
  final String path;
  final String mode;
  final String type;
  final String sha;
  final int? size;
  final String url;

  OctoNode(this.path, this.mode, this.type, this.sha, this.size, this.url);

  factory OctoNode.fromJson(Map<String, dynamic> json) =>
      _$OctoNodeFromJson(json);

  Map<String, dynamic> toJson() => _$OctoNodeToJson(this);
}
