import 'dart:io';

import 'package:banner/banner.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/BannerShowWidget.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_common/widget/divider.dart';
import 'package:barber_store/core/main/home/entitys/home_entity.dart';
import 'package:barber_store/core/main/home_tab_screen.dart';
import 'package:barber_store/core/main/i_refresh.dart';
import 'package:barber_store/helpers/request_helper.dart';
import 'package:flutter/material.dart';

//import 'package:amap_location/amap_location.dart';
//import 'package:amap_location/amap_location_option.dart';

//import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RefreshPage {
  HomeEntity homeEntity;

  @override
  void initState() {
    HomeTabScreenState.tabStates[0] = this;
    super.initState();
    refreshPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void refreshPage() {
    RequestHelper.refreshHome().then((onValue) {
      setState(() {
        homeEntity = onValue;
      });
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var imageH = WindowUtils.isIPhoneX(context) ? 180 + 24 : 180;
    var bannerHeight = Platform.isAndroid
        ? WindowUtils.getScreenHeight() * 0.28
        : WindowUtils.getScreenWidth() / 375.0 * imageH;
    return Scaffold(
      appBar: new Toolbar(
        leading: null,
        title: const Text('欢迎'),
      ),
      body: homeEntity != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new BannerView(
                  data: homeEntity.banners,
                  height: bannerHeight,
                  buildShowView: (int index, data) {
                    return new BannerShowWidget(picUrl: data.picUrl);
                  },
                  onBannerClickListener: (int index, data) {
                    ToastUtils.toast(data.title);
                  },
                ),
                CSDivider(
                  colorHeight: 20.0,
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                  child: Text("最近常去"),
                ),
              ],
            )
          : Text("ing..."),
    );
  }
}
