import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/helpers/navigator_helper.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_store/core/cardbag/addcardbag/add_card_ag_pre_show_dialog.dart';
import 'package:barber_store/core/cardbag/entitys/all_project_entity.dart';
import 'package:barber_store/core/paypassword/affirm_pay_password_screen.dart';
import 'package:barber_store/helpers/request_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardBagScreen extends BasePageRoute {
  final List<StoreAllProject> onValue;

  AddCardBagScreen(this.onValue);

  @override
  _AddCardBagScreenState createState() => _AddCardBagScreenState();

  @override
  String getRouteName() {
    return "AddCardBagScreen";
  }
}

class _AddCardBagScreenState extends State<AddCardBagScreen> {
  StoreAllProject selectProject;
  Subtypes selectSubjectProject;
  int count = 0;
  TextEditingController countTextEditingController =
      TextEditingController(text: "10");

  TextEditingController itemMoneyTextEditingController =
      TextEditingController(text: "0");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var edgeInsets = new EdgeInsets.only(top: 10.0);
    const textStyle = const TextStyle();
    return new Scaffold(
        appBar: new Toolbar(
          title: new Text('添加卡包'),
        ),
        body: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: new ListView(
                children: <Widget>[
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: '项目类型',
                  contentPadding: EdgeInsets.zero,
                ),
                isEmpty: selectProject == null,
                child: DropdownButton<StoreAllProject>(
                  value: selectProject,
                  onChanged: selectFirstOption,
                  items: widget.onValue.map((StoreAllProject value) {
                    return DropdownMenuItem<StoreAllProject>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                ),
              ),
              selectProject == null
                  ? null
                  : InputDecorator(
                      decoration: const InputDecoration(
                        labelText: '子项目类型',
                        contentPadding: EdgeInsets.zero,
                      ),
                      isEmpty: selectSubjectProject == null,
                      child: DropdownButton<Subtypes>(
                        value: selectSubjectProject,
                        onChanged: selectSecondOption,
                        items: selectProject.subtypes.map((Subtypes value) {
                          return DropdownMenuItem<Subtypes>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
              selectSubjectProject == null
                  ? null
                  : Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text("原单价${selectSubjectProject.money}元"),
                    ),
              selectSubjectProject == null
                  ? null
                  : TextField(
                      keyboardType: TextInputType.number,
                      controller: itemMoneyTextEditingController,
                      decoration: const InputDecoration(
                        labelText: "卡包每份单价",
                      ),
                      onChanged: (str) {
                        setState(() {});
                      },
                    ),
              selectSubjectProject == null
                  ? null
                  : SizedBox(
                      width: 100.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: countTextEditingController,
                        decoration: const InputDecoration(
                          labelText: "卡包可使用个数",
                        ),
                        onChanged: (str) {
                          setState(() {});
                        },
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: FlatButton(
                  color: theme.accentColor,
                  onPressed: showAddCardBagPreShowDialog,
                  child: Text("提交"),
                ),
              )
            ].where((o) => o != null).toList()),
          ),
        ));
  }

  int originalPrice() {
    if (selectSubjectProject == null) {
      return 0;
    }
    return selectSubjectProject.money *
        (int.tryParse(countTextEditingController.text) ?? 0);
  }

  void selectFirstOption(StoreAllProject selectProject) {
    setState(() {
      this.selectProject = selectProject;
      this.selectSubjectProject = null;
    });
  }

  void selectSecondOption(Subtypes subtypes) {
    setState(() {
      this.selectSubjectProject = subtypes;
    });
  }

  void showAddCardBagPreShowDialog() {
    if (checkConditions()) {
      NavigatorHelper.showLoadingDialog(true);
      RequestHelper.addCardBagPreDialog(
              countTextEditingController.text,
              selectProject.storeId,
              selectSubjectProject.id,
              itemMoneyTextEditingController.text)
          .then((onValue) {
        NavigatorHelper.showLoadingDialog(false, () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return AddCardBagPreShowDialog(
                    onValue, showAffirmPayPasswordScreen);
              });
        });
      }).catchError((e) {
        NavigatorHelper.showLoadingDialog(false);
      });
    }
  }

  void addCardBag(String paypassword) {
    if (checkConditions()) {
      NavigatorHelper.showLoadingDialog(true);
      RequestHelper.addCardBag(
              countTextEditingController.text,
              selectProject.storeId,
              selectSubjectProject.id,
              itemMoneyTextEditingController.text,
              paypassword)
          .then((onValue) {
        NavigatorHelper.showLoadingDialog(false, () {
          Navigator.popUntil(context, (Route<dynamic> route) {
            return route.settings.name == "CardBagManagerScreen";
          });
        });
      }).catchError((e) {
        NavigatorHelper.showLoadingDialog(false);
      });
    }
  }

  void showAffirmPayPasswordScreen() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AffirmPayPasswordScreen(addCardBag);
        });
  }

  ///前置条件判断
  bool checkConditions() {
    if (selectProject == null || selectSubjectProject == null) {
      ToastUtils.toast("请选择项目后再试");
      return false;
    }
    if ((int.tryParse(countTextEditingController.text) ?? 0) < 0) {
      ToastUtils.toast("可使用次数不正确");
      return false;
    }

    if ((int.tryParse(itemMoneyTextEditingController.text) ?? 0) < 0) {
      ToastUtils.toast("单价金额不正确");
      return false;
    }
    return true;
  }
}
