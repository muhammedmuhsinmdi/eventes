import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/employee/add_employee_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_details_controller.dart';
import 'package:evantez/src/model/core/extensions/common_extension.dart';
import 'package:evantez/src/serializer/models/employee/employee_details/employee_details_model.dart';
import 'package:evantez/src/serializer/models/employee_detail_reponse.dart';
import 'package:evantez/src/view/core/constants/app_images.dart';
import 'package:evantez/src/view/core/constants/app_strings.dart';
import 'package:evantez/src/view/core/constants/constants.dart';
import 'package:evantez/src/view/core/themes/colors.dart';
import 'package:evantez/src/view/core/themes/typography.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/core/widgets/custom_textfield.dart';
import 'package:evantez/src/view/core/widgets/custom_toggle_btn.dart';
import 'package:evantez/src/view/core/widgets/tab_bar.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_list_view/widgets/emp_history_filter.dart';
import 'package:evantez/src/view/view/boys/history_view/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsView extends StatelessWidget {
  final EmployeeDetailsModel employeeDetails;
  const EmployeeDetailsView({super.key, required this.employeeDetails});


  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context, kSize),
        body: SizedBox(
            height: kSize.height,
            width: kSize.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius,
                  AppConstants.baseBorderRadius,
                  0),
              child: Consumer<EmployeeDetasilController>(
                      builder: (context, controller, child) {
                  return Column(
                    children: [
                      empProPicDetail(kSize: kSize, context: context),
                      SizedBox(
                        height: kSize.height * 0.032,
                      ),
                      Divider(
                        color: AppColors.secondaryColor.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: kSize.height * 0.032,
                      ),
                      CustomTabBarView(
                        selectedTap: (value) {
                          controller.selectedTab.value = value;
                        },
                        tabItems: const ['Basic info', 'History'],
                      ),
                      ValueListenableBuilder<int>(
                          valueListenable: controller.selectedTab,
                          builder: (context, value, child) {
                            return value == 0
                                ? basicInfo(context, kSize)
                                : historySection(context, kSize);
                          })
                    ],
                  );
                }
              ),
            )));
  }

  AppBar appBar(BuildContext context, Size kSize) {
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.employeeText,
        style: AppTypography.poppinsSemiBold.copyWith(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget empProPicDetail({required Size kSize, required BuildContext context}) {
    return Row(
      children: [
        CircleAvatar(
          radius: kSize.height * 0.050,
        ),
        SizedBox(
          width: kSize.width * 0.018,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: kSize.width * .6,
              child: Text(
                employeeDetails.employeeName ?? '',
                maxLines: 2,
                style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
              ),
            ),
            Row(
              children: [
                Text(
                  employeeDetails.type?.name ?? '',
                  style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
                ),
                SizedBox(
                  width: kSize.width * 0.01,
                ),
                IconButton(
                  onPressed: () {
                    var employeeData = EmployeeDetailResponse()
                      ..address = employeeDetails.address
                      ..bloodGroup = employeeDetails.bloodGroup
                      ..code = employeeDetails.code
                      ..createdAt = employeeDetails.createdAt
                      ..currentRating = employeeDetails.currentRating
                      ..dob = employeeDetails.dob
                      ..email = employeeDetails.email
                      ..employeeMobile = employeeDetails.employeeMobile
                      ..employeeName = employeeDetails.employeeName
                      ..employeeType = employeeDetails.employeeType
                      ..homeContact = employeeDetails.homeContact
                      ..id = employeeDetails.id
                      ..idProofNumber = employeeDetails.idProofNumber
                      ..idProofType = employeeDetails.idProofType
                      ..image = employeeDetails.image
                      ..isActive = employeeDetails.isActive
                      ..totalEarnings = employeeDetails.totalEarnings
                      ..updatedAt = employeeDetails.updatedAt
                      ..user = employeeDetails.user;

                    context
                        .read<AddEmployeeController>()
                        .employeeInitStateLoading(data: employeeData);
                    Navigator.pushNamed(
                        context, RouterConstants.addEmployeeViewRoute);

                    // ChangeEmpPosition(
                    //   parentContext: context,
                    //   positions: controller.types,
                    // ).show();
                  },
                  icon: SvgPicture.asset(
                    AppImages.edit,
                    height: kSize.height * 0.025,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget basicInfo(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeeDetasilController>();
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: kSize.height * 0.032,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.activeText,
                    style: AppTypography.poppinsMedium.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  CustomToggleBtn(
                    active: controller.employeeDetailsModel!.isActive,
                    onChanged: (value) async{
                      var token  = context.read<AuthController>().accesToken??"";
                      await controller.onChangeEmployeeState(value, token);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Text(
                AppStrings.proInfoText,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              proInfo('Age', '${employeeDetails.dob?.day}'),
              SizedBox(
                height: kSize.height * 0.016,
              ),
              proInfo(AppStrings.bloodGroup, '${employeeDetails.bloodGroup}'),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              proInfo(AppStrings.phoneText, ''),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              proInfo(AppStrings.homeContactText, '${employeeDetails.homeContact}'),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Divider(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Text(
                AppStrings.address,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              Text(
                employeeDetails.address ?? "",
                maxLines: 4,
                style: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Divider(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Text(
                AppStrings.paymentDetailsText,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              Text(
                AppStrings.bankDetails,
                maxLines: 4,
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.01,
              ),
              if(employeeDetails.employeePaymentDetails!.isNotEmpty)
              Text(
                "${employeeDetails.employeePaymentDetails![0].bankName ?? ''}\n ${employeeDetails.employeePaymentDetails![0].branchName ?? ''}\n${employeeDetails.employeePaymentDetails![0].ifscCode ?? ''}",
                maxLines: 4,
                style: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              Text(
                AppStrings.panCardText,
                maxLines: 4,
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.01,
              ),
              Text(
                employeeDetails.idProofNumber ?? "0",
                maxLines: 4,
                style: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Divider(
                color: AppColors.secondaryColor.withOpacity(0.3),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Text(
                AppStrings.paymentDetailsText,
                style: AppTypography.poppinsSemiBold.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
              Text(
                AppStrings.totalEarningsText,
                maxLines: 4,
                style: AppTypography.poppinsMedium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.01,
              ),
              Text(
                "₹ ${employeeDetails.totalEarnings}",
                maxLines: 4,
                style: AppTypography.poppinsRegular.copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: kSize.height * 0.032,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget proInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.poppinsMedium,
        ),
        Text(
          value,
          style: AppTypography.poppinsMedium,
        )
      ],
    );
  }

   Widget historySection(BuildContext context, Size kSize) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(
        top: kSize.height * 0.032,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.totalDueText,
                style: AppTypography.poppinsMedium.copyWith(
                  fontSize: 14,
                ),
              ),
              Text(
                16762.formattedAmount,
                textAlign: TextAlign.end,
                style: AppTypography.poppinsSemiBold.copyWith(
                  fontSize: 18,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          Divider(
            color: AppColors.secondaryColor.withOpacity(0.3),
          ),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          searchField(kSize, context),
          SizedBox(
            height: kSize.height * 0.024,
          ),
          historyListing(kSize),
        ],
      ),
    ));
  }

  Widget historyListing(Size kSize) {
    return Expanded(
      child: ListView.builder(
          itemCount: employeeDetails.employeeHistory      !.length,
          padding: EdgeInsets.only(bottom: kSize.height * 0.1),
          itemBuilder: (context, index) {
            return HistoryTile(
              index: index,
            );
          }),
    );
  }


  Widget searchField(Size kSize, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomTextField(
            text: '',
            hintText: AppStrings.searchText,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SvgPicture.asset(
                AppImages.search,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        SizedBox(
          width: kSize.width * 0.032,
        ),
        SizedBox(
          width: kSize.width * 0.1,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              ),
              onPressed: () {
                // history filter
                EmpHistoryFilter(context).show();
              },
              child: SvgPicture.asset(
                AppImages.filter,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              )),
        )
      ],
    );
  }
}
