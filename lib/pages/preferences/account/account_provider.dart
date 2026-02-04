import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_lunch/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_lunch/utils/banner_utils.dart' show BannerTypes;
import 'package:smart_lunch/utils/images.dart' as images;

class AccountProvider with ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String bannerType = "";
  String bannerMessage = "";

  XFile? pickedProfileImage;
  File? profileImageFile;
  final ImagePicker imagePicker = ImagePicker();

  void updateBanner(String type, AppLocalizations? appLocalizations) {
    bannerType = type;
    if (type == BannerTypes.successBanner.type) {
      bannerMessage = appLocalizations!.updated_profile_succesfully;
    } else if (type == BannerTypes.warningBanner.type) {
      bannerMessage = appLocalizations!.verify_information;
    } else if (type == BannerTypes.errorBanner.type) {
      bannerMessage = appLocalizations!.error_updating_profile;
    } else {
      bannerMessage = appLocalizations!.try_again_later;
    }
    notifyListeners();
  }

  Future<void> selectProfilePicture(
    ImageSource imageSource,
  ) async {
    developer.log(imageSource.toString(),
        name: "selectProfilePicture_imageSource");

    if (imageSource == ImageSource.camera) {
      await Permission.camera.request().isGranted;
    }
    
    try {
      pickedProfileImage = await imagePicker.pickImage(
        source: imageSource,
        imageQuality: 40,
      );

      if(pickedProfileImage?.path!=null) {
        profileImageFile = File(pickedProfileImage?.path ?? "");
      }
      else{
        await copyAssetToAppDirectory(images.defaultProfileStudentImage, 'temp_image.jpg');
        profileImageFile = File('${(await getTemporaryDirectory()).path}/temp_image.jpg');

      }

      notifyListeners();
    } catch (error) {
      developer.log(error.toString(), name: "selectProfilePicture_error");
    }
  }


  Future<void> copyAssetToAppDirectory(String assetPath, String targetFileName) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();
    String tempPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempPath/$targetFileName';
    await File(filePath).writeAsBytes(bytes);
  }


  void resetImage() {
    pickedProfileImage = null;
    profileImageFile = null;
    notifyListeners();
  }

  void hideBanner() {
    bannerType = "";
    bannerMessage = "";
    notifyListeners();
  }
}
