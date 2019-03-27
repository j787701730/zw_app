import 'package:flutter/material.dart';
import 'util.dart';
import '../pageLoading.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../loading.dart';

class CategoryContent extends StatefulWidget {
  final params;

  CategoryContent(this.params);

  @override
  _CategoryContentState createState() => _CategoryContentState(params);
}

class _CategoryContentState extends State<CategoryContent> {
  final params;

  _CategoryContentState(this.params);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategoryContent();
  }

  int page = 1;
  int size = 1;
  Map result = {};
  Map selectVal = {'1': 'A', '2': 'B', '3': 'C', '4': 'D'};
  Map judgeVal = {'1': '正确', '0': '错误'};
  int pageTemp = 1;
  bool requesting = false;

  _getCategoryContent() {
    setState(() {
      requesting = true;
    });
    ajax('http://apicloud.mob.com/tiku/shitiku/query?page=$page&size=$size&cid=${params['cid']}', (data) {
      if(!mounted) return;
      var obj = jsonDecode(data);
      setState(() {
        requesting = false;
        result = obj['result'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${params['title']}'),
        actions: <Widget>[Loading(requesting)],
      ),
      body: result.isEmpty
          ? PageLoading()
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Center(
                    child:
                        Text('$page / ${result['total']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    '题目',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(result['list'][0]['title']),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    '答案',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                result['list'][0]['tikuType'] == 'select'
                    ? Container(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Wrap(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton(
                                color: '${result['list'][0]['val']}'.contains('A') || result['list'][0]['val'] == '1'
                                    ? Colors.blue
                                    : Colors.white,
                                textColor:
                                    '${result['list'][0]['val']}'.contains('A') || result['list'][0]['val'] == '1'
                                        ? Colors.white
                                        : Colors.black,
                                onPressed: () {},
                                child: Text('A: ${result['list'][0]['a']}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton(
                                color: '${result['list'][0]['val']}'.contains('B') || result['list'][0]['val'] == '2'
                                    ? Colors.blue
                                    : Colors.white,
                                textColor:
                                    '${result['list'][0]['val']}'.contains('B') || result['list'][0]['val'] == '2'
                                        ? Colors.white
                                        : Colors.black,
                                onPressed: () {},
                                child: Text('B: ${result['list'][0]['b']}'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: FlatButton(
                                color: '${result['list'][0]['val']}'.contains('C') || result['list'][0]['val'] == '3'
                                    ? Colors.blue
                                    : Colors.white,
                                textColor:
                                    '${result['list'][0]['val']}'.contains('C') || result['list'][0]['val'] == '3'
                                        ? Colors.white
                                        : Colors.black,
                                onPressed: () {},
                                child: Text('C: ${result['list'][0]['c']}'),
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                color: '${result['list'][0]['val']}'.contains('D') || result['list'][0]['val'] == '4'
                                    ? Colors.blue
                                    : Colors.white,
                                textColor:
                                    '${result['list'][0]['val']}'.contains('D') || result['list'][0]['val'] == '4'
                                        ? Colors.white
                                        : Colors.black,
                                onPressed: () {},
                                child: Text('D: ${result['list'][0]['d']}'),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Wrap(
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              color: result['list'][0]['val'] == '1' ? Colors.blue : Colors.white,
                              textColor: result['list'][0]['val'] == '1' ? Colors.white : Colors.black,
                              child: Icon(Icons.check),
                            ),
                            FlatButton(
                              onPressed: () {},
                              color: result['list'][0]['val'] == '0' ? Colors.blue : Colors.white,
                              textColor: result['list'][0]['val'] == '0' ? Colors.white : Colors.black,
                              child: Icon(Icons.clear),
                            ),
                          ],
                        ),
                      ),
                result['list'][0]['file'] != ''
                    ? Container(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                        child: Image.network(
                          result['list'][0]['file'],
                          fit: BoxFit.contain,
                          width: 150,
                          height: 150,
                        ),
                      )
                    : Placeholder(
                        fallbackHeight: 1,
                        color: Colors.transparent,
                      ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '正确答案',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      result['list'][0]['tikuType'] == 'select'
                          ? Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(result['list'][0]['val'].length == 1
                                  ? selectVal[result['list'][0]['val']]
                                  : result['list'][0]['val']),
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(judgeVal[result['list'][0]['val']]),
                            ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    '解释',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(result['list'][0]['explainText']),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Offstage(
                        offstage: page == 1,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              page -= 1;
                              pageTemp = page;
                              _getCategoryContent();
                            });
                          },
                          child: Text('上一题'),
                        ),
                      ),
                      Offstage(
                          offstage: page == 1 || page == result['total'],
                          child: SizedBox(
                            width: 10,
                          )),
                      Offstage(
                        offstage: page == result['total'],
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              page += 1;
                              pageTemp = page;
                              _getCategoryContent();
                            });
                          },
                          child: Text('下一题'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('跳转  '),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          controller: TextEditingController.fromValue(TextEditingValue(
                              // 设置内容
                              text: '$pageTemp',
                              selection: TextSelection.fromPosition(
                                  TextPosition(affinity: TextAffinity.downstream, offset: '$pageTemp'.length))
                              // 保持光标在最后
                              )),
                          onChanged: (val) {
                            if (int.parse(val) > result['total']) {
                              setState(() {
                                pageTemp = result['total'];
                              });
                              return;
                            }
                            setState(() {
                              pageTemp = int.parse(val);
                            });
                          },
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly, // 整数
                            BlacklistingTextInputFormatter.singleLineFormatter // 单行
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            page = pageTemp;
                            _getCategoryContent();
                          });
                        },
                        child: Text('跳转'),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
