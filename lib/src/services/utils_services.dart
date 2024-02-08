import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  // Salva dado localmente em segurança
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  // Recupera dado salvo localmente em segurança
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  // Remove dado salvo localmente
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime.toLocal());
  }

  Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;

    return base64.decode(base64String);
  }

  void showToast({
    required String message,
    bool isError = false,
  }) {
    Get.snackbar(
      '',
      '',
      titleText: Container(),
      messageText: Center(
        child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      icon: isError
          ? const Icon(
              Icons.cancel_rounded,
              color: Colors.red,
            )
          : const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
      duration: const Duration(seconds: 4),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          isError ? const Color(0XFFF5E6E6) : const Color(0xFFECF5E6),
      isDismissible: true,
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 10),
    );
  }
}
