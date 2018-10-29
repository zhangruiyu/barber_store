import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_store/core/cardbag/entitys/all_project_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddCardBagScreen extends BasePageRoute {
  final List<ProjectEntity> onValue;

  AddCardBagScreen(this.onValue);

  @override
  _AddCardBagScreenState createState() => _AddCardBagScreenState();

  @override
  String getRouteName() {
    return "AddCardBagScreen";
  }
}

class _AddCardBagScreenState extends State<AddCardBagScreen> {
  ProjectEntity selectProject;
  Subtypes selectSubjectProject;
  int count = 0;
  TextEditingController countTextEditingController =
  TextEditingController(text: "0");

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
    print(selectProject);
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
                    child: DropdownButton<ProjectEntity>(
                      value: selectProject,
                      onChanged: selectFirstOption,
                      items: widget.onValue.map((ProjectEntity value) {
                        return DropdownMenuItem<ProjectEntity>(
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("原单价${selectSubjectProject.money}元"),
                  ),
                  selectSubjectProject == null
                      ? null
                      : TextField(
                    keyboardType: TextInputType.number,
                    controller: itemMoneyTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "卡包单价",
                    ),
                    onChanged: (str) {
                      setState(() {});
                    },
                  ),
                  SizedBox(
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
                      onPressed: () {},
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

  void selectFirstOption(ProjectEntity selectProject) {
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
}
