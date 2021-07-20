import 'package:json_annotation/json_annotation.dart';

import 'octo_node.dart';

part 'octo_tree.g.dart';

@JsonSerializable()
class OctoTree {
  final String? sha;
  final String? url;
  @JsonKey(name: 'tree')
  final List<OctoNode>? nodes;
  final bool? truncated;
  final String? message;
  @JsonKey(name: 'documentation_url')
  final String? documentationUrl;

  OctoTree(
    this.sha,
    this.url,
    this.nodes,
    this.truncated,
    this.message,
    this.documentationUrl,
  );

  factory OctoTree.fromJson(Map<String, dynamic> json) =>
      _$OctoTreeFromJson(json);

  Map<String, dynamic> toJson() => _$OctoTreeToJson(this);
}
