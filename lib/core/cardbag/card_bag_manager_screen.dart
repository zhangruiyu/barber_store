import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/models/app_state.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_store/core/cardbag/addcardbag/add_card_bag_screen.dart';
import 'package:barber_store/helpers/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CardBagManagerScreen extends BasePageRoute {
  @override
  _CardBagManagerScreenState createState() => _CardBagManagerScreenState();

  @override
  String getRouteName() {
    return "CardBagManagerScreen";
  }
}

class _CardBagManagerScreenState extends State<CardBagManagerScreen> {
  var titles = ['销售中', '准备中'];

  @override
  Widget build(BuildContext context) {
    var edgeInsets = new EdgeInsets.only(top: 10.0);
    var theme = Theme.of(context);
    const textStyle = const TextStyle();
    return new StoreBuilder<AppState>(builder: (context, store) {
      var currentUser = store.state.currentUser;
      return DefaultTabController(
          length: titles.length,
          child: new Scaffold(
              appBar: new Toolbar(
                title: new Text('卡包管理'),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        RequestHelper.addCardBagPre().then((onValue) {
                          Navigator.push(
                              context, AddCardBagScreen(onValue).route());
                        });
                      })
                ],
                bottom: TabBar(
                  tabs: titles
                      .map<Widget>(
                        (String page) => Tab(text: page),
                      )
                      .toList(),
                ),
              ),
              body: new TabBarView(children: <Widget>[
                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      key: Key(index.toString()),
                      color: Colors.purple,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              '900元',
                              style: theme.textTheme.subhead.merge(TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0)),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text("抵扣剪发卡",
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.subhead.merge(
                                          TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        )),
                                    Text("X10",
                                        textAlign: TextAlign.right,
                                        style: theme.textTheme.subhead.merge(
                                          TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text("可以抵扣剪发,一次性可使用多张"),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Text("转为准备中"),
                            height: 100.0,
                            color: Colors.tealAccent,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: 20,
                ),
                Text("2")
              ])));
    });
  }
}
