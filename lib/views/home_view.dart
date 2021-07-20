import 'package:flutter/material.dart';
import 'package:mzone/styles.dart';
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

  _HomeViewState() : categories = ValueNotifier([]);

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
      body: Row(
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
                    builder: (context, List<OctoNode> categoriesValue, child) {
                      return ListView.builder(
                        itemCount: categoriesValue.length,
                        itemBuilder: (context, i) {
                          final category = categoriesValue[i];
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            title: Text(
                              category.path,
                              style: TextStyles.category,
                            ),
                            onTap: () {},
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
            child: ArticleView(),
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
}
