import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/typography.dart';

class EventImageUpload extends StatefulWidget {
  final Function(File) onPicked;

  const EventImageUpload({super.key, required this.onPicked});

  @override
  State<EventImageUpload> createState() => _EventImageUploadState();
}

class _EventImageUploadState extends State<EventImageUpload> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return InkWell(
      highlightColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      onTap: () {
        selectMode(context: context);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(top: kSize.height * 0.032),
        decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(
              AppConstants.basePadding,
            )),
        height: kSize.height * 0.2,
        width: kSize.width,
        child: pickedImage != null
            ? Stack(
                children: [
                  SizedBox(
                    height: kSize.height * 0.2,
                    width: kSize.width,
                    child: Image.file(
                      pickedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(6.0),
                          backgroundColor: AppColors.accentDark,
                          shape: const CircleBorder()),
                      onPressed: () {
                        selectMode(context: context);
                      },
                      child: Icon(
                        Icons.edit,
                        color: AppColors.greyColor,
                        size: kSize.height * 0.022,
                      ),
                    ),
                  )
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.uploadImg,
                    height: kSize.height * 0.085,
                    width: kSize.height * 0.085,
                    colorFilter: const ColorFilter.mode(
                        AppColors.darkGreyColor, BlendMode.srcIn),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: kSize.height * 0.012),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppConstants.baseBorderRadius),
                      color: AppColors.blackColor.withOpacity(0.6),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: kSize.width * 0.032,
                        vertical: kSize.height * 0.003),
                    child: Text(
                      "Upload Image",
                      style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
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
                vertical: AppConstants.largePadding,
                horizontal: AppConstants.largePadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: AppConstants.baseBorderRadius),
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
                        pickImage(
                            source: ImageSource.gallery, context: context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.photo,
                            size: kSize.height * 0.032,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: AppConstants.marginSpace),
                            child: Text(
                              "Gallery",
                              style: AppTypography.poppinsRegular
                                  .copyWith(fontSize: 14),
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
                            padding: const EdgeInsets.only(
                                top: AppConstants.marginSpace),
                            child: Text(
                              "Camera",
                              style: AppTypography.poppinsRegular
                                  .copyWith(fontSize: 14),
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
      XFile? imagePicked =
          await imagePicker.pickImage(source: source, imageQuality: 70);
      if (imagePicked != null) {
        pickedImage = File(imagePicked.path);
        setState(() {});
        _setBase(pickedImage!);
        if (context.mounted) {
          Navigator.pop(context);
        }
        if (pickedImage != null) {
          widget.onPicked(pickedImage!);
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
    String base64 = base64Encode(imageBytes);
    // base64 string has the value you need to upload , just declare to any variable
  }
}
