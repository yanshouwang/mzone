import 'package:flutter/material.dart';
import 'package:mzone/styles.dart';
import 'package:mzone/util.dart';
import 'package:mzone/util/octo_kit.dart';
import 'package:mzone/util/octo_node.dart';

import 'article_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<List<OctoNode>> categories;
  ValueNotifier<OctoNode?> article;

  _HomeViewState()
      : categories = ValueNotifier([]),
        article = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    try {
      final owner = 'yanshouwang';
      final repo = 'mzone';
      final tree0 = await octo.getTree(owner, repo, 'master');
      if (tree0.nodes == null) {
        throw tree0.message!;
      }
      final node =
          tree0.nodes!.firstWhere((element) => element.path == 'categories');
      final tree1 = await octo.getTree(owner, repo, node.sha);
      categories.value = tree1.nodes ?? [];
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('$e'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 240.0,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/24455689?v=4',
                              ),
                              radius: 40.0,
                            ),
                            SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'iAMD',
                                  style: TextStyles.title,
                                ),
                                Text(
                                  'AMD yes!',
                                  style: TextStyles.signature,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: categories,
                          builder:
                              (context, List<OctoNode> categoriesValue, child) {
                            return ListView.builder(
                              itemCount: categoriesValue.length,
                              itemBuilder: (context, i) {
                                final category = categoriesValue[i];
                                return ExpansionTile(
                                  tilePadding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  childrenPadding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  title: Text(
                                    category.path,
                                    style: TextStyles.category,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                  children: [
                                    buildArticles(category),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: article,
                    builder: (context, OctoNode? articleValue, child) {
                      return ArticleView(
                        key: articleValue == null
                            ? null
                            : Key(articleValue.path),
                        article: articleValue,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40.0,
            child: Center(
              child: Text(
                'Copyright @ ${DateTime.now().year} yanshouwang. All rights reserved. Powered by Flutter.',
                style: TextStyles.copyright,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    categories.dispose();
    super.dispose();
  }

  Widget buildArticles(OctoNode category) {
    return FutureBuilder(
      future: octo.getTree(owner, repo, category.sha),
      builder: (context, AsyncSnapshot<OctoTree> snapshot) {
        if (snapshot.hasData) {
          final nodes = snapshot.data!.nodes ?? [];
          return Column(
            children: nodes.where((node) => node.path.endsWith('.md')).map(
              (node) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  title: Text(
                    node.path.substring(0, node.path.length - 3),
                    style: TextStyles.category,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () => article.value = node,
                );
              },
            ).toList(),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
