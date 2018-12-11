import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_store/core/cardbag/addcardbag/add_card_bag_screen.dart';
import 'package:barber_store/core/cardbag/card_bag_manager_page.dart';
import 'package:barber_store/core/cardbag/card_bag_market_page.dart';
import 'package:barber_store/helpers/request_helper.dart';
import 'package:flutter/material.dart';

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
                        Navigator.push(context,
                            AddCardBagScreen(onValue.storeAllProject).route());
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
              CardBagMarketPage(),
              CardBagManagerPage()
            ])));
  }
}
