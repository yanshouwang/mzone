import 'dart:convert';

import 'package:http/http.dart' as http;

import 'octo_blob.dart';
import 'octo_config.dart';
import 'octo_tree.dart';

final OctoKit octo = _OctoKit();

abstract class OctoKit {
  Future<OctoTree> getTree(String owner, String repo, String treeSHA);
  Future<OctoBlob> getBlob(String owner, String repo, String fileSHA);
}

class _OctoKit implements OctoKit {
  @override
  Future<OctoTree> getTree(String owner, String repo, String treeSHA) async {
    final url = Uri.parse(
        'https://api.github.com/repos/$owner/$repo/git/trees/$treeSHA');
    final reply = await http.get(url, headers: headers);
    final decoded = json.decode(reply.body);
    final tree = OctoTree.fromJson(decoded);
    return tree;
  }

  @override
  Future<OctoBlob> getBlob(String owner, String repo, String fileSHA) async {
    final url = Uri.parse(
        'https://api.github.com/repos/$owner/$repo/git/blobs/$fileSHA');
    final reply = await http.get(url, headers: headers);
    final decoded = json.decode(reply.body);
    final blob = OctoBlob.fromJson(decoded);
    return blob;
  }

  Map<String, String> get headers => {'Authorization': 'Basic $token'};
}
