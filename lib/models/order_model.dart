class SuccessOrderModel {
  final bool success;
  final Order order;

  SuccessOrderModel({
    required this.success,
    required this.order,
  });
}

class Order {
  final String id;
  final String user;
  final Coupon? coupon;
  final List<OrderItem> orderItems;
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
    this.coupon,
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
}

class Coupon {
  final String id;
  final String code;
  final int discount;

  Coupon({
    required this.id,
    required this.code,
    required this.discount,
  });
}

class OrderItem {
  final String id;
  final Product product;
  final int quantity;
  final String? color;
  final String? size;
  final double price;
  final int v;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    this.color,
    this.size,
    required this.price,
    required this.v,
  });
}

class Product {
  final String id;
  final String name;
  final String category;
  final String brand;
  final String description;
  final int quantityInStock;
  final double price;
  final List<String>? colors;
  final List<String>? sizes;
  final bool isDiscounted;
  final int? discountAmount;
  final bool isApproved;
  final List<dynamic>? reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.description,
    required this.quantityInStock,
    required this.price,
    this.colors,
    this.sizes,
    required this.isDiscounted,
    this.discountAmount,
    required this.isApproved,
    this.reviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}
