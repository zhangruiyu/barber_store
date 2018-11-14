class CardBagEntity {
  int id;
  String name;
  int storeId;
  String storeSubtypeId;
  int count;
  String createTime;
  int discountTotalPrice;
  int originalTotalPrice;
  int payCount;
  int state;

  CardBagEntity(
      {this.id,
      this.name,
      this.storeId,
      this.storeSubtypeId,
      this.count,
      this.createTime,
      this.discountTotalPrice,
      this.originalTotalPrice,
      this.payCount,
      this.state});

  CardBagEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'];
    storeSubtypeId = json['store_subtype_id'];
    count = json['count'];
    createTime = json['create_time'];
    discountTotalPrice = json['discount_total_price'];
    originalTotalPrice = json['original_total_price'];
    payCount = json['pay_count'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['store_subtype_id'] = this.storeSubtypeId;
    data['count'] = this.count;
    data['create_time'] = this.createTime;
    data['discount_total_price'] = this.discountTotalPrice;
    data['original_total_price'] = this.originalTotalPrice;
    data['pay_count'] = this.payCount;
    data['state'] = this.state;
    return data;
  }
}
