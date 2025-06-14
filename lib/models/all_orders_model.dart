class AllOrderModel {
  final String message;
  final List<Order> orders;

  AllOrderModel({
    required this.message,
    required this.orders,
  });

  factory AllOrderModel.fromJson(Map<String, dynamic> json) {
    return AllOrderModel(
      message: json['message'],
      orders:
          (json['orders'] as List).map((item) => Order.fromJson(item)).toList(),
    );
  }
}

class Order {
  final String id;
  final String user;
  final dynamic coupon;
  final List<String> orderItems;
  final String shippingAddress;
  final String shippingMethod;
  final String trackCode;
  final String status;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Order({
    required this.id,
    required this.user,
    required this.coupon,
    required this.orderItems,
    required this.shippingAddress,
    required this.shippingMethod,
    required this.trackCode,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      user: json['user'],
      coupon: json['coupon'],
      orderItems: List<String>.from(json['orderItems']),
      shippingAddress: json['shippingAddress'],
      shippingMethod: json['shippingMethod'],
      trackCode: json['trackCode'],
      status: json['status'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
