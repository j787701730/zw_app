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
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
                  child: Text(
                    article['hp_title'],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('文 / ${article['author'][0]['user_name']}'),
                ),
                Html(
                  data: article['hp_content'],
                  padding: EdgeInsets.only(left: 20, right: 20),
                  defaultTextStyle: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Text(
                    '${article['hp_author_introduce']} ${article['editor_email']}',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    '作者',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      height: 4,
                      width: 60,
                      color: Colors.black87,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: article['author_list'].map<Widget>((list) {
                      return Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                            width: 44,
                            height: 44,
                            child: ClipOval(
                              child: Image.network(
                                '${list['web_url']}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      list['user_name'],
                                      style: TextStyle(height: 1.5),
                                    ),
                                  ),
                                  Container(
                                    child: Text(list['desc'], style: TextStyle(height: 1.5)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    '评论列表',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      height: 4,
                      width: 60,
                      color: Colors.black87,
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                comments.isEmpty
                    ? Placeholder(
                        fallbackHeight: 1,
                        color: Colors.transparent,
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
                        child: Column(
                          children: comments['data'].map<Widget>((comment) {
                            return Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)), color: Colors.black),
                                        width: 20,
                                        height: 20,
                                        child: ClipOval(
                                          child: Image.network(
                                            '${comment['user']['web_url']}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(comment['user']['user_name']),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(comment['input_date']),
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(comment['content']),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.thumb_up,
                                        color: Colors.black38,
                                        size: 16,
                                      ),
                                      Text(' ${comment['praisenum']}',style: TextStyle(
                                          color: Colors.black38
                                      ),)
                                    ],
                                  ),
                                  Container(
//                                  height: 1,
//                                  color: Colors.black38,
                                    padding: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.black12
                                            )
                                        )
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
              ],
            ),
    );
  }
}
