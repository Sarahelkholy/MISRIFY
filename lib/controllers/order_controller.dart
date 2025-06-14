import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graduation_project1/models/payment_response_model.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';
import '../../models/cart_response.dart';
import '../../views/auth/login_Screen.dart';

class OrderController extends GetxController {
  final box = GetStorage();
  RxBool isPlacingOrder = false.obs;

  Future<String?> placeOrder({
    required List<CartItem> cartItems,
    required String shippingAddress,
    String shippingMethod = 'standard',
    String? couponCode,
    bool isRetrying = false,
  }) async {
    final token = box.read('token');
    if (token == null) {
      Get.offAll(() => const LoginScreen());
      return null;
    }

    isPlacingOrder.value = true;
    final url = Uri.parse('$appBaseUrl/user/order');

    // 🟢 Send only fields your backend accepts
    final body = {
      "orderItems": cartItems.map((item) {
        final discountedPrice = item.product.isDiscounted
            ? item.product.price - item.product.discountAmount
            : item.product.price;

        return {
          "product": item.product.id,
          "quantity": item.quantity,
          "color": item.color,
          "size": item.size,
          "price": discountedPrice, // ✅ Required now
        };
      }).toList(),
      "shippingAddress": shippingAddress,
      "shippingMethod": shippingMethod,
      if (couponCode != null && couponCode.isNotEmpty) "coupon": couponCode,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'accessToken=$token',
        },
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);
      print("📦 place order: ${response.body}");

      if (response.statusCode == 201 && decoded['success'] == true) {
        final orderId = decoded['order']['_id'];
        return orderId;
      } else if (response.statusCode == 401 && !isRetrying) {
        return await _refreshTokenAndRetry(
          cartItems,
          shippingAddress,
          shippingMethod,
          couponCode,
        );
      } else {
        final error = decoded['message'] ?? 'Failed to place order';
        Get.snackbar("Order Failed", error,
            backgroundColor: Colors.red, colorText: Colors.white);
        return null;
      }
    } catch (e) {
      debugPrint("🚨 Order error: $e");
      Get.snackbar("Error", "Unexpected error occurred",
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    } finally {
      isPlacingOrder.value = false;
    }
  }

  Future<String?> _refreshTokenAndRetry(
    List<CartItem> cartItems,
    String shippingAddress,
    String shippingMethod,
    String? couponCode,
  ) async {
    final refreshToken = box.read('refreshToken');
    if (refreshToken == null) {
      Get.offAll(() => const LoginScreen());
      return null;
    }

    final refreshUrl = Uri.parse('$appBaseUrl/auth/refresh-token');
    final refreshResponse = await http.post(
      refreshUrl,
      headers: {
        'Cookie': refreshToken,
        'Content-Type': 'application/json',
      },
    );

    if (refreshResponse.statusCode == 200) {
      final newCookie = refreshResponse.headers['set-cookie'];
      final match = RegExp(r'accessToken=([^;]+)').firstMatch(newCookie ?? '');
      if (match != null) {
        final newToken = match.group(1);
        box.write('token', newToken);
        return await placeOrder(
          cartItems: cartItems,
          shippingAddress: shippingAddress,
          shippingMethod: shippingMethod,
          couponCode: couponCode,
          isRetrying: true,
        );
      }
    }

    Get.offAll(() => const LoginScreen());
    return null;
  }

  Future<String?> getPaymentIframeUrl(String orderId) async {
    final token = box.read('token');
    if (token == null) {
      Get.offAll(() => const LoginScreen());
      return null;
    }

    final url = Uri.parse('$appBaseUrl/user/payment');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'accessToken=$token',
        },
        body: jsonEncode({"orderId": orderId}),
      );

      final decoded = jsonDecode(response.body);
      print('💳 Payment Response: $decoded');

      if (response.statusCode == 200 && decoded['success'] == true) {
        return decoded['data']['iframeUrl'];
      } else {
        final errorMsg = decoded['message'] ??
            decoded['error']?.toString() ??
            'Unknown error';
        debugPrint('❌ Payment URL Error: $errorMsg');
        Get.snackbar('Payment Error', errorMsg,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint('❌ Payment Exception: $e');
      Get.snackbar('Payment Error', 'Failed to connect to payment service',
          backgroundColor: Colors.red, colorText: Colors.white);
    }

    return null;
  }
}
