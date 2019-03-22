import 'package:flutter/material.dart';
import '../pageLoading.dart';
import 'util.dart';
import 'dart:convert';

//import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
//import 'package:flutter_html/flutter_html.dart';
//import 'package:html/dom.dart' as dom;
//import 'html.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class ArticleContent extends StatefulWidget {
  final params;

  ArticleContent(this.params);

  @override
  _ArticleContentState createState() => _ArticleContentState(params);
}

class _ArticleContentState extends State<ArticleContent> {
  final Map params;

  _ArticleContentState(this.params);

  Map article = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getArticle();
  }

  _getArticle() {
    ajax('http://v3.wufazhuce.com:8000/api/essay/${params['item_id']}', (data) {
      print(jsonEncode(data));
      if (!mounted) return;
      setState(() {
        article = data['data'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(params['title']),
      ),
      body: article.isEmpty
          ? PageLoading()
          : ListView(
              children: <Widget>[
                Container(
                  child: Text(article['hp_title']),
                ),
                Container(
                  child: Text('文 / ${article['hp_author']}'),
                ),
//                NewsDetailsWeb(body: article['hp_content']),
                Html(data: article['hp_content'],padding: EdgeInsets.all(8),)
//                Html(
//                  data: article['hp_content'],
//                  padding: EdgeInsets.all(8.0),
//                  linkStyle: const TextStyle(
//                    color: Colors.redAccent,
//                    decorationColor: Colors.redAccent,
//                    decoration: TextDecoration.underline,
//                  ),
//                  onLinkTap: (url) {
//                    print("Opening $url...");
//                  },
//                  customRender: (node, children) {
//                    if (node is dom.Element) {
//                      print(node.toString());
//                      switch (node.localName) {
//                        case "p":
////                          return Column(children: children);
//                          return Container(
//                            padding: EdgeInsets.all(10),
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              child: Text(node.innerHtml),
//                            ),
//                          );
//                      }
//                    }
//                  },
//                )
              ],
            ),
    );
  }
}
