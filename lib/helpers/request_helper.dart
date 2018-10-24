import 'dart:async';

import 'package:barber_common/helpers/net_work.dart';
import 'package:barber_store/core/main/account/entitys/account_entity.dart';
import 'package:barber_store/core/main/home/entitys/home_entity.dart';

class RequestHelper {


  static Future<AccountEntity> refreshAccount() {
    return RequestClient.request<AccountEntity>(
            (json) => AccountEntity.fromJson(json), '/account/common/refresh');
  }


  static Future<HomeEntity> refreshHome() {
    return RequestClient.request<HomeEntity>(
            (json) => HomeEntity.fromJson(json), '/home/canLogin/refresh');
  }
}
