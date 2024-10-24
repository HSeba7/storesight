import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storesight/components/cached_image.dart';
import 'package:storesight/components/custom_text.dart';
import 'package:storesight/components/model_sheet.dart';
import 'package:storesight/infrastructure/enums.dart';
import 'package:storesight/size_config.dart';

class CircleImage extends StatelessWidget {
  final String? imageSrc;
  final String avatarLetters;
  final double width, height;

  const CircleImage({
    super.key,
    required this.imageSrc,
    required this.avatarLetters,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return imageSrc != null && imageSrc!.isNotEmpty
        ? SizedBox(
            width: width,
            height: height,
            child: CustomCachedImage(
              url: imageSrc!,
              imageType: ImageType.network,
              boxFit: BoxFit.fill,
              boxShape: BoxShape.circle,
            ),
          )
        : SizedBox(
            width: width,
            height: height,
            child: CircleAvatar(
              backgroundColor: color.primaryColor,
              child: CustomText(
                text: avatarLetters,
                maxlines: 1,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color.primaryColorLight,
              ),
            ),
          );
  }
}

class CustomImagePicker extends StatelessWidget {
  const CustomImagePicker({
    super.key,
    required this.widgetBuilder,
    required this.onFilePick,
    this.enabled = true,
    this.onDelete,
    this.title = "Edytuj zdjęcie profilowe",
    this.icon = "assets/icons/edit.svg",
    this.onMultiFilePick,
  });

  final Widget Function() widgetBuilder;
  final Function(File) onFilePick;
  final Function(List<File>)? onMultiFilePick;
  final Function()? onDelete;
  final bool? enabled;
  final String title, icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => enabled! ? _showBottomSheet(context) : null,
      child: widgetBuilder.call(),
    );
  }

  void _showBottomSheet(BuildContext context) {
    var color = Theme.of(context);
    showModalBottomSheet(
        context: context,
        backgroundColor: color.colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (BuildContext buildContext) {
          return CustomModelSheet(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      width: width(25),
                      height: height(25),
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    CustomText(
                      fontSize: width(15),
                      text: title,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(
                  height: height(20),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: color.primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: width(15),
                    vertical: height(20),
                  ),
                  child: Column(
                    children: [
                      EditPhotoListTile(
                        title: "Zrobić zdjęcie",
                        image: 'assets/icons/camera.svg',
                        onTap: () {
                          _getFromCamera(context);
                        },
                      ),
                      SizedBox(
                        height: height(10),
                      ),
                      Divider(
                        color: color.colorScheme.secondary,
                      ),
                      SizedBox(
                        height: height(10),
                      ),
                      EditPhotoListTile(
                        title: "Wybierz zdjęcie",
                        image: 'assets/icons/gallery.svg',
                        onTap: () {
                          if (onMultiFilePick != null) {
                            _getMultipuleFromGallery(context);
                          } else {
                            _getFromGallery(context);
                          }
                        },
                      ),
                      if (onDelete != null) ...[
                        SizedBox(
                          height: height(10),
                        ),
                        Divider(
                          color: color.colorScheme.secondary,
                        ),
                        SizedBox(
                          height: height(10),
                        ),
                        EditPhotoListTile(
                          title: "Delete Photo",
                          image: 'assets/icons/delete.svg',
                          onTap: onDelete!,
                        ),
                      ]
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  _getFromGallery(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  _getMultipuleFromGallery(BuildContext context) async {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFiles.isNotEmpty) {
      List<File> images = [];
      for (var image in pickedFiles) {
        images.add(File(image.path));
      }
      onMultiFilePick?.call(images);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      onFilePick.call(File(pickedFile.path));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }
}

class EditPhotoListTile extends StatelessWidget {
  const EditPhotoListTile({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title, image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            fontSize: width(15),
            text: title,
            fontWeight: FontWeight.w600,
          ),
          SvgPicture.asset(
            image,
            width: width(20),
            height: height(20),
            color: color.primaryColorLight,
          ),
        ],
      ),
    );
  }
}

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.profileImage,
    required this.onPickImage,
    required this.profileImageUrl,
  });

  final File? profileImage;

  final String? profileImageUrl;

  final Function(File) onPickImage;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context);
    return CustomImagePicker(
      widgetBuilder: () => SizedBox(
        height: height(140),
        width: width(140),
        child: Stack(
          children: [
            Container(
              width: width(140),
              height: height(140),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.colorScheme.onPrimaryContainer,
                  width: width(5),
                ),
                color: color.hintColor,
              ),
              child: profileImage != null
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(profileImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : CheckImageAvailable(
                      profileImageUrl: profileImageUrl,
                    ),
            ),
            Positioned(
              bottom: 5,
              right: 15,
              child: Container(
                width: width(30),
                height: height(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.primaryColor,
                ),
                child: SvgPicture.asset(
                  "assets/icons/edit.svg",
                  width: width(15),
                  height: height(15),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
      onFilePick: onPickImage,
    );
  }
}

class CheckImageAvailable extends StatelessWidget {
  const CheckImageAvailable({Key? key, required this.profileImageUrl})
      : super(key: key);

  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return profileImageUrl == null || profileImageUrl!.isEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(25),
              vertical: height(25),
            ),
            child: SvgPicture.asset(
              "assets/icons/people.svg",
              color: Colors.white,
            ))
        : CustomCachedImage(
            url: profileImageUrl!,
            boxFit: BoxFit.cover,
            boxShape: BoxShape.circle,
          );
  }
}
