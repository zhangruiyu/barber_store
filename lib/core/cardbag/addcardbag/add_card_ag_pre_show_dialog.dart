import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_store/core/cardbag/addcardbag/add_card_ag_pre_show_dialog_entity.dart';
import 'package:flutter/material.dart';

class AddCardBagPreShowDialog extends StatefulWidget {
  final AddCardBagPreShowDialogEntity data;

  AddCardBagPreShowDialog(this.data);

  @override
  _AddCardBagPreShowDialogState createState() =>
      _AddCardBagPreShowDialogState();
}

class _AddCardBagPreShowDialogState extends State<AddCardBagPreShowDialog> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
                height: 50.0,
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                      onPressed: () {
                        Navigator.canPop(context) && Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    new Flexible(
                      child: new Container(
                        padding: const EdgeInsets.only(right: 44.0),
                        child: new Text(
                          "确认卡包信息",
                          style: theme.textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      flex: 1,
                      fit: FlexFit.tight,
                    )
                  ],
                )),
            new Divider(
              height: 10.0,
            ),
          ]
            ..add(SizedBox(
              height: WindowUtils.getScreenHeight() * 0.3,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var projectNames =
                  widget.data.infoList[index];
                  return ListTile(
                    title: Text(projectNames.title),
                    subtitle: Text(projectNames.subtitle),
                    trailing: Text(projectNames.trailing),
                  );
                },
                itemCount: widget.data.infoList.length,
              ),
            ))
            ..add(Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              width: WindowUtils.getScreenWidth(),
              child: FlatButton(
                  color: theme.accentColor,
                  onPressed: () {
//                    showAffirmPayPasswordScreen();
                  },
                  textColor: Colors.white,
                  child: Text(widget.data.affirmText)),
            ))
            ..toList(),
        ),
      ),
    );
  }
}
