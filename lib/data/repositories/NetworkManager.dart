// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:graduation_project1/constants/constants.dart';

// class NetworkManager extends GetxController {
//   static NetworkManager get instance => Get.find();
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     _connectionStatus.value = result;
//     if (_connectionStatus.value == ConnectivityResult.none) {
//       Get.snackbar('Error...!', 'No internet Connection',
//           colorText: kLightWhite,
//           backgroundColor: kRed,
//           icon: const Icon(Icons.error_outline));
//     }
//   }

//   Future<bool> isConnected() async {
//     try {
//       final result = await _connectivity.checkConnectivity();
//       if (result == ConnectivityResult.none) {
//         return false;
//       } else {
//         return true;
//       }
//     } on PlatformException catch (_) {
//       return false;
//     }
//   }

//   @override
//   void onClose() {
//     super.onClose();
//     _connectivitySubscription.cancel();
//   }
// }
