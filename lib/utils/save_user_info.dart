  import 'package:smart_lunch/common_providers/storage_provider.dart';

Future<void> saveUserCafeteria(StorageProvider storageProvider, String cafeteriaID) async{
  await storageProvider.writeValue(
              "cafeteriaId",
               cafeteriaID
        );
}

Future<void> saveUserInfo(StorageProvider storageProvider, String accessToken, String refreshToken, String userType, String userId, String familyId) async{
        await storageProvider.writeValue("accessToken", accessToken);
        await storageProvider.writeValue("refreshToken", refreshToken);
        await storageProvider.writeValue("userType", userType);

        if(userType=="Tutor" || userType=="Teacher"){
          await storageProvider.writeValue(
                  "tutorId",
                  userId,
          );
        }
        else if(userType=="Student"){
          await storageProvider.writeValue(
                  "studentId",
                  userId,
          );
        }
       await storageProvider.writeValue("familyId", familyId);
  }