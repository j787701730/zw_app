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
  Map comments = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getArticle();
    _getComment();
  }

  _getArticle() {
    ajax('http://v3.wufazhuce.com:8000/api/essay/${params['item_id']}', (data) {
      print(jsonEncode(data));
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          article = data['data'];
        });
      }
    });
  }

  _getComment() {
    ajax('http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/${params['item_id']}/0', (data) {
      print('评论');
      print(jsonEncode(data));
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          comments = data['data'];
        });
      }
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
                  child: Text('文 / ${article['author'][0]['user_name']}'),
                ),
                Html(
                  data: article['hp_content'],
                  padding: EdgeInsets.all(8),
                ),
                Container(
                  child: Text(article['hp_author_introduce']),
                ),
                Container(
                  child: Text(article['editor_email']),
                ),
                Container(
                  child: Text(
                    '作者',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: article['author_list'].map<Widget>((list) {
                    return Row(
                      children: <Widget>[
                        SizedBox(
                          width: 50,
                          child: Image.network(
                            '${list['web_url']}',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(list['user_name']),
                              ),
                              Container(
                                child: Text(list['desc']),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }).toList(),
                ),
                Container(
                  child: Text(
                    '评论列表',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                comments.isEmpty
                    ? Placeholder(
                        fallbackHeight: 1,
                        color: Colors.transparent,
                      )
                    : Column(
                        children: comments['data'].map<Widget>((comment) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 40,
                                    child: Image.network(comment['user']['web_url']),
                                  ),
                                  Expanded(
                                    child: Text(comment['user']['user_name']),
                                  ),
                                  SizedBox(
                                    child: Text(comment['input_date']),
                                  )
                                ],
                              ),
                              Container(
                                child: Text(comment['content']),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.black38,
                                  ),
                                  Text('${comment['praisenum']}')
                                ],
                              )
                            ],
                          );
                        }).toList(),
                      )
              ],
            ),
    );
  }
}
