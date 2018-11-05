class AddCardBagPreShowDialogEntity {
  String affirmText;
  List<InfoList> infoList;

  AddCardBagPreShowDialogEntity({this.affirmText, this.infoList});

  AddCardBagPreShowDialogEntity.fromJson(Map<String, dynamic> json) {
    affirmText = json['affirmText'];
    if (json['infoList'] != null) {
      infoList = new List<InfoList>();
      json['infoList'].forEach((v) {
        infoList.add(new InfoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affirmText'] = this.affirmText;
    if (this.infoList != null) {
      data['infoList'] = this.infoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfoList {
  String title;
  String subtitle;
  String trailing;

  InfoList({this.title, this.subtitle, this.trailing});

  InfoList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    trailing = json['trailing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['trailing'] = this.trailing;
    return data;
  }
}
