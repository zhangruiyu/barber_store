import 'package:barber_common/helpers/navigator_helper.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_store/core/cardbag/entitys/card_bag_entity.dart';
import 'package:barber_store/helpers/request_helper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class CardBagManagerPage extends StatefulWidget {
  @override
  _CardBagManagerPageState createState() => _CardBagManagerPageState();
}

class _CardBagManagerPageState extends State<CardBagManagerPage> {
  List<CardBagEntity> data = [];

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return RefreshIndicator(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          var itemData = data[index];
          return Card(
            key: Key(index.toString()),
            color: Colors.purple,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    '${itemData.discountTotalPrice}元',
                    style: theme.textTheme.subhead.merge(TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0)),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
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
                  onPressed: () {
                    addCardBagStateMarket(itemData.id);
                  },
                  child: Text("转为准备中"),
                  height: 100.0,
                  color: Colors.tealAccent,
                )
              ],
            ),
          );
        },
        itemCount: data.length,
      ),
      onRefresh: refreshData,
    );
  }

  Future<Null> refreshData() {
    final Completer<Null> completer = new Completer<Null>();
    RequestHelper.allCardBagByType(0).then((onValue) {
      setState(() {
        data.clear();
        data.addAll(onValue);
      });
      completer.complete(null);
    }).catchError((onError) {
      completer.complete(null);
    });
    return completer.future;
  }

  void addCardBagStateMarket(int cardBagId) {
    NavigatorHelper.showLoadingDialog(true);
    RequestHelper.setCardBagStateByState(1, cardBagId).then((onValue) {
      NavigatorHelper.showLoadingDialog(false);
      ToastUtils.toast("已添加为销售中");
      refreshData();
    }).catchError((onError) {
      NavigatorHelper.showLoadingDialog(false);
    });
  }
}
