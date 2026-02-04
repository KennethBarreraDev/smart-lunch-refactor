import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_lunch/utils/images.dart' as images;

class ProfilePictureAvatar extends StatelessWidget {
  const ProfilePictureAvatar({
    super.key,
    required this.width,
    required this.height,
    required this.profileImageFile,
    required this.profileImageUrl,
    required this.onPressed,
  });

  final double width;
  final double height;
  final File? profileImageFile;
  final String? profileImageUrl;
  final Future<void> Function(ImageSource)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          /*
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Seleccionar imagen",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      onPressed?.call(ImageSource.gallery).then(
                            (value) => Navigator.of(context).pop(),
                          );
                    },
                    child: const Text("Galería"),
                  ),
                  TextButton(
                    onPressed: () {
                      onPressed?.call(ImageSource.camera).then(
                            (value) => Navigator.of(context).pop(),
                          );
                    },
                    child: const Text("Cámara"),
                  )
                ],
              );
            },
          );
           */
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: (profileImageFile != null ||
                      (profileImageUrl ?? "").isNotEmpty)
                  ? BoxFit.cover
                  : BoxFit.contain,
              image: profileImageFile != null
                  ? FileImage(
                      profileImageFile!,
                    )
                  : (profileImageUrl ?? "").isNotEmpty
                      ? ResizeImage(
                          NetworkImage(
                            profileImageUrl ?? "",
                          ),
                          allowUpscaling: true,
                          policy: ResizeImagePolicy.fit,
                          width: 262,
                          height: 262,
                        )
                      : const ResizeImage(
                          AssetImage(
                            images.defaultProfileStudentImage,
                          ),
                          allowUpscaling: true,
                          policy: ResizeImagePolicy.fit,
                          width: 262,
                          height: 262,
                        ) as ImageProvider<Object>,
            ),
          ),
        ),
      ),
    );
  }
}
