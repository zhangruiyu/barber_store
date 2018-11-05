import 'dart:async';

import 'package:barber_common/helpers/net_work.dart';
import 'package:barber_store/core/cardbag/addcardbag/add_card_ag_pre_show_dialog_entity.dart';
import 'package:barber_store/core/cardbag/entitys/all_project_entity.dart';
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

  static Future<List<ProjectEntity>> addCardBagPre() {
    return RequestClient.request<List<ProjectEntity>>(
        (json) => (json as List).map((f) {
              return ProjectEntity.fromJson(f);
            }).toList(),
        '/store/storeManager/addCardBagPre');
  }

  static Future<AddCardBagPreShowDialogEntity> addCardBagPreDialog(String count,
      int storeId, String storeSubtypeId, String discountItemPrice) {
    return RequestClient.request<AddCardBagPreShowDialogEntity>((json) {
      return AddCardBagPreShowDialogEntity.fromJson(json);
    }, '/store/storeManager/addCardBagPreShow', {
      'count': count,
      'store_id': storeId,
      'store_subtype_id': storeSubtypeId,
      'discount_item_price': discountItemPrice
    });
  }
}
