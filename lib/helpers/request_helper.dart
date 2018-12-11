import 'dart:async';

import 'package:barber_store/core/cardbag/addcardbag/add_card_ag_pre_show_dialog_entity.dart';
import 'package:barber_store/core/cardbag/entitys/all_project_entity.dart';
import 'package:barber_store/core/cardbag/entitys/card_bag_entity.dart';
import 'package:barber_store/core/main/account/entitys/account_entity.dart';
import 'package:barber_store/core/main/home/entitys/home_entity.dart';
import 'package:barber_store/helpers/net_work.dart';

class RequestHelper {
  static Future<AccountEntity> refreshAccount() {
    return AppRequestClient.request<AccountEntity>('/account/common/refresh');
  }

  static Future<HomeEntity> refreshHome() {
    return AppRequestClient.request<HomeEntity>('/home/canLogin/refresh');
  }

  static Future<AllProjectEntity> addCardBagPre() {
    return AppRequestClient.request<AllProjectEntity>(
        '/store/storeManager/addCardBagPre');
  }

  static Future<AddCardBagPreShowDialogEntity> addCardBagPreDialog(String count,
      int storeId, String storeSubtypeId, String discountItemPrice) {
    return AppRequestClient.request<AddCardBagPreShowDialogEntity>(
        '/store/storeManager/addCardBagPreShow', {
      'count': count,
      'store_id': storeId,
      'store_subtype_id': storeSubtypeId,
      'discount_item_price': discountItemPrice
    });
  }

  static Future<Object> addCardBag(String count, int storeId,
      String storeSubtypeId, String discountItemPrice, String paypassword) {
    return AppRequestClient.request<Object>('/store/storeManager/addCardBag', {
      'count': count,
      'store_id': storeId,
      'store_subtype_id': storeSubtypeId,
      'discount_item_price': discountItemPrice,
      'paypassword': paypassword
    });
  }

  static Future<CardBagEntity> allCardBagByType(int type) {
    return AppRequestClient.request<CardBagEntity>(
        '/store/storeManager/allCardBagByType', {
      'type': type,
    });
  }

  static Future<Object> setCardBagStateByState(int state, int cardBagId) {
    return AppRequestClient.request<Object>(
        '/store/storeManager/setCardBagStateByState', {
      'state': state,
      'cardBagId': cardBagId,
    });
  }
}
