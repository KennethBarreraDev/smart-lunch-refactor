import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_lunch/utils/urls.dart' as urls;

class RestorePasswordProvider with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  bool isLoading = false;
  bool successRequest = true;

  Future<bool> sendVerificationEmail() async {
    isLoading = true;
    notifyListeners();
    await http.post(Uri.parse(urls.passwordRecoveryUrl),
        body: {"email": userEmailController.text}).then((value) {
      isLoading = false;
      notifyListeners();

      if (value.statusCode == 200) {
        successRequest = true;
      } else {
        successRequest = false;
      }
      
      print(userEmailController.text);
      print(urls.passwordRecoveryUrl);
      print(value.statusCode);
      print(value.body);
    });
     notifyListeners();
    return successRequest;
  }

  void resetRequestValue() {
    successRequest = true;
    notifyListeners();
  }
}
