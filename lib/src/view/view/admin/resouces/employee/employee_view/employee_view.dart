import 'dart:developer';

import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/model/repository/auth/auth_controller.dart';
import 'package:evantez/src/model/repository/resource/employee/add_employee_controller.dart';
import 'package:evantez/src/model/repository/resource/employee_repository.dart';
import 'package:evantez/src/view/core//constants/app_images.dart';
import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//widgets/custom_toggle_btn.dart';
import 'package:evantez/src/view/core//widgets/tab_bar.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_view/widgets/change_position_bottom_sheet.dart';
import 'package:evantez/src/view/view/boys/history_view/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_back_btn.dart';
import '../../../../../core/widgets/custom_textfield.dart';
import '../employee_list_view/widgets/emp_history_filter.dart';

class EmployeeDetailView extends StatefulWidget {
  EmployeeDetailView({super.key, required this.id});
  final int id;
  @override
  State<EmployeeDetailView> createState() => _EmployeeDetailViewState();
}

class _EmployeeDetailViewState extends State<EmployeeDetailView> {
  final ValueNotifier<int> selectedTab = ValueNotifier<int>(0);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final EmployeesController controller =
          context.read<EmployeesController>();
      final AuthController authController = context.read<AuthController>();
      controller.employeeDetails(
          token: authController.accesToken ?? "", id: widget.id);
      controller.employeeRatingHistory(
          token: authController.accesToken ?? "", category: '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppConstants.baseBorderRadius,
              AppConstants.baseBorderRadius, AppConstants.baseBorderRadius, 0),
          child: Column(
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
                  //
                  selectedTab.value = value;
                },
                tabItems: const ['Basic', 'History'],
              ),
              ValueListenableBuilder<int>(
                  valueListenable: selectedTab,
                  builder: (context, value, child) {
                    return value == 0
                        ? basicInfo(context, kSize)
                        : historySection(context, kSize);
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget empProPicDetail({required Size kSize, required BuildContext context}) {
    final controller = context.watch<EmployeesController>();
    final addEmployeeController = context.watch<AddEmployeeController>();
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
                controller.employeeData?.employeeName ?? '',
                maxLines: 2,
                style: AppTypography.poppinsSemiBold.copyWith(fontSize: 24),
              ),
            ),
            Row(
              children: [
                /*    Wrap(
                  children: List.generate(
                      controller.selectedEmpList.value.length,
                      (index) => Text(controller.selectedEmpList.value[index])),
                ), */
                Text(
                  controller.selectedPosition?.value ?? '',
                  style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
                ),
                SizedBox(
                  width: kSize.width * 0.01,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouterConstants.addEmployeeViewRoute);
                      addEmployeeController.employeeInitStateLoading(
                          data: controller.employeeData);
                      //
                      // List<String> positions = [
                      //   "Supervisor",
                      //   "Head",
                      //   'Captain',
                      //   "Vice Captain",
                      //   "Main Boy",
                      //   'A Boy',
                      //   "B Boy"
                      // ];
                      ChangeEmpPosition(
                        parentContext: context,
                        positions: controller.types,
                      ).show();
                    },
                    icon: SvgPicture.asset(AppImages.edit,
                        height: kSize.height * 0.025,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryColor,
                          BlendMode.srcIn,
                        )))
              ],
            )
          ],
        )
      ],
    );
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

  Widget basicInfo(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeesController>();
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
                    onChanged: (value) {
                      //
                      log("$value");
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
              proInfo('Age', '${controller.employeeData?.dob?.day}'),
              SizedBox(
                height: kSize.height * 0.016,
              ),
              proInfo(AppStrings.bloodGroup,
                  '${controller.employeeData?.bloodGroup}'),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              proInfo(AppStrings.phoneText, ''),
              SizedBox(
                height: kSize.height * 0.024,
              ),
              proInfo(AppStrings.homeContactText,
                  '${controller.employeeData?.homeContact}'),
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
                controller.employeeData?.address ?? "",
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
              Text(
                "${controller.employeePayment?.bankName ?? ''}\n ${controller.employeePayment?.branchName ?? ''}\n${controller.employeePayment?.ifscCode ?? ''}",
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
                controller.employeeData?.idProofNumber ?? "0",
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
                "₹ ${controller.employeeData?.totalEarnings}",
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
                AppStrings.activeText,
                style: AppTypography.poppinsMedium.copyWith(
                  fontSize: 14,
                ),
              ),
              Text(
                "16762",
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
    final controller = context.watch<EmployeesController>();
    return Expanded(
      child: ListView.builder(
          itemCount: controller.employeeRatingsList.length,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: SvgPicture.asset(
                AppImages.search,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
              ),
              onPressed: () {
                // history filter
                EmpHistoryFilter(context).show();
              },
              child: SvgPicture.asset(
                AppImages.filter,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              )),
        )
      ],
    );
  }
}
