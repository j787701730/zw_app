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

class MovieContent extends StatefulWidget {
  final params;

  MovieContent(this.params);

  @override
  _MovieContentState createState() => _MovieContentState(params);
}

class _MovieContentState extends State<MovieContent> {
  final Map params;

  _MovieContentState(this.params);

  List articles = [];
  Map comments = {};
  Map pics = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPics();
    _getArticle();
    _getComment();
  }

  _getPics() {
    ajax('http://v3.wufazhuce.com:8000/api/movie/detail/${params['item_id']}', (data) {
      print(jsonEncode(data));
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          pics = data['data'];
        });
      }
    });
  }

  _getArticle() {
    ajax('http://v3.wufazhuce.com:8000/api/movie/${params['item_id']}/story/1/0', (data) {
      if (!mounted) return;
      if (data['res'] == 0) {
        setState(() {
          articles = data['data']['data'];
        });
      }
    });
  }

  _getComment() {
    ajax('http://v3.wufazhuce.com:8000/api/comment/praiseandtime/movie/${params['item_id']}/0', (data) {
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
      body: articles.isEmpty
          ? PageLoading()
          : ListView(
              children: <Widget>[
                pics.isEmpty
                    ? Placeholder(
                        fallbackHeight: 1,
                        color: Colors.transparent,
                      )
                    : Container(
                        child: Image.network(
                          pics['detailcover'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                Column(
                  children: articles.map<Widget>((article) {
                    return Column(
                      children: <Widget>[
                        Container(
                          child: Text(article['title']),
                        ),
                        Container(
                          child: Text('文 / ${article['user']['user_name']}'),
                        ),
//                NewsDetailsWeb(body: article['hp_content']),
                        Html(
                          data: article['content'],
                          padding: EdgeInsets.all(8),
                        ),
                        Container(
                          child: Text(article['charge_edt']),
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
