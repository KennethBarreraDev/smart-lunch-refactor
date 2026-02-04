import 'package:flutter/material.dart';
import 'package:smart_lunch/common_providers/common_providers.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? _locale;
  final supportedLocales = [
    'en',
    'es'
  ];

  

  Locale? get locale => _locale;

  Future<void> loadLocale(StorageProvider storageProvider) async {
    String? languageCode = await storageProvider.readValue('language_code');
    print("Current languaje is");
    print(languageCode);

    if (languageCode.isNotEmpty) {
      print('Entro al if');
      _locale = Locale(languageCode);
    } else {
        Locale deviceLocale = WidgetsBinding.instance.window.locales.first;
      if(supportedLocales.contains(deviceLocale.languageCode.toLowerCase())){
        print(deviceLocale.languageCode);
      _locale = Locale(deviceLocale.languageCode);
      }
      else{
        _locale = const Locale('en');
      }

    }
    notifyListeners();
  }
  
  Future<void> changeLanguage(Locale locale, StorageProvider storageProvider) async {

    await  storageProvider.writeValue('language_code', locale.languageCode);
    _locale = locale;
    notifyListeners();
  }
}
