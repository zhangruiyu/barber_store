class AllProjectEntity {
  List<StoreAllProject> storeAllProject;

  AllProjectEntity({this.storeAllProject});

  AllProjectEntity.fromJson(Map<String, dynamic> json) {
    if (json['store_all_project'] != null) {
      storeAllProject = new List<StoreAllProject>();
      json['store_all_project'].forEach((v) {
        storeAllProject.add(new StoreAllProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeAllProject != null) {
      data['store_all_project'] =
          this.storeAllProject.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreAllProject {
  int id;
  List<Subtypes> subtypes;
  String name;
  int storeId;
  String addTime;

  StoreAllProject(
      {this.id, this.subtypes, this.name, this.storeId, this.addTime});

  StoreAllProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['subtypes'] != null) {
      subtypes = new List<Subtypes>();
      json['subtypes'].forEach((v) {
        subtypes.add(new Subtypes.fromJson(v));
      });
    }
    name = json['name'];
    storeId = json['store_id'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.subtypes != null) {
      data['subtypes'] = this.subtypes.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['add_time'] = this.addTime;
    return data;
  }
}

class Subtypes {
  String id;
  String pic;
  String name;
  int money;
  String createTime;

  Subtypes({this.id, this.pic, this.name, this.money, this.createTime});

  Subtypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    name = json['name'];
    money = json['money'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['name'] = this.name;
    data['money'] = this.money;
    data['create_time'] = this.createTime;
    return data;
  }
}
