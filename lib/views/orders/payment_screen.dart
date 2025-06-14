import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:graduation_project1/controllers/cart_controller.dart';
import 'package:graduation_project1/views/orders/success_order_screen.dart';

class PaymentWebViewScreen extends StatelessWidget {
  final String iframeUrl;
  const PaymentWebViewScreen({super.key, required this.iframeUrl});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) async {
            if (_isSuccessUrl(url)) {
              await cartController.clearCart();
              await cartController.refreshCartCount();
              Get.offAll(() => const SuccessOrderScreen());
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(iframeUrl));

    return Scaffold(
      appBar: AppBar(title: const Text("Secure Payment")),
      body: WebViewWidget(controller: controller),
    );
  }

  bool _isSuccessUrl(String url) {
    // Match against Paymob success URL or query parameter
    return url.contains("payment-success") ||
        url.contains("txn_response_code=APPROVED");
  }
}
