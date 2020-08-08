class OrderData {
  int id;
  String total;
  String order_status;
  String date_placed;

  OrderData({this.id, this.total, this.order_status, this.date_placed});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    order_status = json['order_status'];
    date_placed = json['date_placed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    data['order_status'] = this.order_status;
    data['date_placed'] = this.date_placed;
    return data;
  }
}
