import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final iosOptions =
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  final androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<String> readValue(String key) async {
    String value = (await storage.read(
            key: key, iOptions: iosOptions, aOptions: androidOptions) ??
        "");
    return value;
  }

  Future<void> writeValue(String key, dynamic value) async {
    await storage.write(
        key: key, value: value, iOptions: iosOptions, aOptions: androidOptions);
  }

  Future<void> deleteValue(String key) async {
    await storage.delete(
        key: key, iOptions: iosOptions, aOptions: androidOptions);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
