import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_store/core/cardbag/entitys/all_project_entity.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
//    selectProject = widget.onValue[0];
  }

  @override
  Widget build(BuildContext context) {
    var edgeInsets = new EdgeInsets.only(top: 10.0);
    const textStyle = const TextStyle();
    return new Scaffold(
        appBar: new Toolbar(
          title: new Text('添加卡包'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.send), onPressed: () {})
          ],
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
                        onChanged: (Subtypes newValue) {
                          setState(() {
                            selectSubjectProject = newValue;
                          });
                        },
                        items: selectProject.subtypes.map((Subtypes value) {
                          return DropdownMenuItem<Subtypes>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                      ),
                    ),
            ].where((o) => o != null).toList()),
          ),
        ));
  }

  void selectFirstOption(ProjectEntity selectProject) {
    setState(() {
      this.selectProject = selectProject;
//      this.selectSubjectProject = selectProject.subtypes[0];
    });
  }
}
