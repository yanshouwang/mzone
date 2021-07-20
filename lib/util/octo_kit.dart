import 'dart:convert';

import 'package:http/http.dart' as http;

import 'octo_tree.dart';

final OctoKit octo = _OctoKit();

abstract class OctoKit {
  Future<OctoTree> getTree(String owner, String repo, String treeSHA);
}

class _OctoKit implements OctoKit {
  @override
  Future<OctoTree> getTree(String owner, String repo, String treeSHA) async {
    final url = Uri.parse(
        'https://api.github.com/repos/$owner/$repo/git/trees/$treeSHA');
    final reply = await http.get(url);
    final decoded = json.decode(reply.body);
    final tree = OctoTree.fromJson(decoded);
    return tree;
  }
}
