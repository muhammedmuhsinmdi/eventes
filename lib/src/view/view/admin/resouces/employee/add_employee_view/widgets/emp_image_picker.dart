import 'dart:convert';
import 'dart:io';

import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class EmpImageTile extends StatefulWidget {
  final Function(File?, String) onSelectedImage;
  const EmpImageTile({super.key, required this.onSelectedImage});

  @override
  State<EmpImageTile> createState() => _EmpImageTileState();
}

class _EmpImageTileState extends State<EmpImageTile> {
  File? pickedImage;
  String? base64Data;

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: () {
        selectMode(context: context);
      },
      child: pickedImage != null
          ? Container(
              clipBehavior: Clip.antiAlias,
              height: kSize.height * 0.08,
              width: kSize.height * 0.08,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.file(
                pickedImage!,
                fit: BoxFit.cover,
              ),
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: AppConstants.basePadding),
                  padding: const EdgeInsets.all(AppConstants.marginSpace),
                  clipBehavior: Clip.antiAlias,
                  height: kSize.height * 0.072,
                  width: kSize.height * 0.072,
                  decoration: const BoxDecoration(
                    color: AppColors.accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppImages.camera,
                    colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
                    // color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  AppStrings.takePhotoText,
                  style: AppTypography.poppinsMedium.copyWith(
                    color: AppColors.secondaryColor,
                    fontSize: 14,
                  ),
                )
              ],
            ),
    );
  }

  selectMode({required BuildContext context}) {
    final kSize = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.accentDark,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.accentColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.baseBorderRadius),
                topRight: Radius.circular(AppConstants.baseBorderRadius))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppConstants.largePadding, horizontal: AppConstants.largePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.baseBorderRadius),
                  child: Text(
                    "Select Image",
                    style: AppTypography.poppinsRegular.copyWith(fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onTap: () {
                        pickImage(source: ImageSource.gallery, context: context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo,
                            size: kSize.height * 0.032,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppConstants.marginSpace),
                            child: Text(
                              "Gallery",
                              style: AppTypography.poppinsRegular.copyWith(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onTap: () {
                        pickImage(source: ImageSource.camera, context: context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.camera,
                            size: kSize.height * 0.032,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppConstants.marginSpace),
                            child: Text(
                              "Camera",
                              style: AppTypography.poppinsRegular.copyWith(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<File> pickImage({
    required ImageSource source,
    required BuildContext context,
  }) async {
    final imagePicker = ImagePicker();
    try {
      XFile? imagePicked = await imagePicker.pickImage(source: source, imageQuality: 70);
      if (imagePicked != null) {
        pickedImage = File(imagePicked.path);
        setState(() {});
        _setBase(pickedImage!);
        if (context.mounted) {
          Navigator.pop(context);
        }
        if (pickedImage != null) {
          widget.onSelectedImage(pickedImage!, base64Data!);
        }
        return pickedImage!;
      }
    } catch (_) {}
    return pickedImage!;
  }

  // If you need the image as base64 , you can use function call
  _setBase(File image) async {
    List<int> imageBytes = [];
    imageBytes = image.readAsBytesSync();
    base64Data = base64Encode(imageBytes);
    // base64 string has the value you need to upload , just declare to any variable
  }
}
