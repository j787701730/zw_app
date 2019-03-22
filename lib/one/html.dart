import 'dart:io';

//import 'package:demonewsapp/page/native_web_view.dart';
//import 'package:demonewsapp/page/webview.dart';


import 'htmlw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html;
import 'package:path_provider/path_provider.dart';

class NewsDetailsWeb extends StatefulWidget {
  String body;
  List<Widget> widgets;

  NewsDetailsWeb({Key key, @required String this.body, List<Widget> this.widgets}) : super(key: key);

  @override
  NewsDetailsWebState createState() {
    return NewsDetailsWebState();
  }
}

class NewsDetailsWebState extends State<NewsDetailsWeb> {
  final String fileName = 'wenshan_details.html';
  final String fileCssName = 'wenshan_details_css.css';
  String _webUrl = '';
  double top = 156.899;

  @override
  void initState() {
    super.initState();
    _createHtmlContent();
  }

  void _createHtmlContent() async {
//    String cssUrl = (await _getLocalCssFile()).uri.toString();
//    String cssHead =
//        '''<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
//    <link rel="stylesheet" type="text/css" href="${cssUrl}" />''';
//    String newHtml = cssHead + widget.body;
//    dom.Document doc = html.parse(newHtml);
    dom.Document doc = html.parse(widget.body);
    String htmlContent = doc.outerHtml;
    print('htmlContent === $htmlContent');
    _writeDataFile(htmlContent);
  }

  void _checkCssFile() async {
    File file = await _getLocalCssFile();
    bool isExist = await file.exists();
    int fileLength = isExist ? await file.length() : -1;
    print('csss file length === $fileLength');
    if (!isExist || fileLength <= 0) {
      if (isExist) {
        await file.delete();
      }
      await file.create();
      String cssStr = await DefaultAssetBundle.of(context).loadString('css/one.css');
      print('csss ==== $cssStr');
      await file.writeAsString(cssStr);
    }
  }

  void _writeDataFile(String data) async {
    _checkCssFile();
    File file = await _getLocalHtmlFile();
    File afterFile = await file.writeAsString(data);
    setState(() {
      _webUrl = afterFile.uri.toString();
    });
    print('weburl ==== $_webUrl');
  }

  Future<File> _getLocalCssFile() async {
// 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
// 返回本地文件目录
    return new File('$dir/$fileCssName');
  }

  Future<File> _getLocalHtmlFile() async {
// 获取本地文档目录
    String dir = (await getApplicationDocumentsDirectory()).path;
// 返回本地文件目录
    return new File('$dir/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return getHtmlView();
  }

  Widget getNativeWeb() {
    return _webUrl.isNotEmpty
        ? NativeWebView(
            webUrl: _webUrl,
            webRect: Rect.fromLTWH(
                0.0,
                0.0,
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top),
          )
        : new Container(
            height: 300.0,
            color: Colors.yellow,
          );
  }

//  Widget getRectSizeWeb() {
//    return _webUrl.isNotEmpty
//        ? new WebViewWidget(
//            url: _webUrl,
//            webRect:
//                Rect.fromLTWH(0.0, top, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height - top),
//            withZoom: false,
//            withLocalStorage: true,
//            scrollBar: false,
//          )
//        : new Container(
//            height: 300.0,
//            color: Colors.yellow,
//          );
//  }

  Widget getHtmlView() {
    return Container(
      child: Html(
        data: widget.body,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
