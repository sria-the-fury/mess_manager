import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGetSnackbar{

  success(title, message){
    return Get.snackbar(title, message,
        shouldIconPulse: false,
        icon: const Icon(Icons.check_circle, color: Colors.white,),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.teal.shade700.withOpacity(0.8),
        colorText: Colors.white,
        maxWidth: 300);

  }

  error(title, message) {
    return Get.snackbar(title, message,
        shouldIconPulse: false,
        icon: const Icon(Icons.error, color: Colors.white,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        maxWidth: 300);
  }

  warning(title, message) {
    return Get.snackbar(title, message,
        shouldIconPulse: false,
        icon: const Icon(Icons.warning, color: Colors.white,),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.deepOrange.withOpacity(0.8),
        colorText: Colors.white,
        maxWidth: 300);
  }
}