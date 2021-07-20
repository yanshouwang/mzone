import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class ArticleView extends StatefulWidget {
  const ArticleView({Key? key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  _ArticleViewState()
      : source = ValueNotifier(''),
        controller = ScrollController();

  final ValueNotifier<String> source;
  final ScrollController controller;

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: source,
      builder: (context, String value, child) {
        return Markdown(
          data: value,
          selectable: true,
          controller: controller,
          extensionSet: md.ExtensionSet(
            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            [
              md.EmojiSyntax(),
              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    source.dispose();
    super.dispose();
  }
}
