import 'package:evantez/app/router/router_constant.dart';
import 'package:evantez/src/controller/resources/employee/employee_details_controller.dart';
import 'package:evantez/src/model/helper/debounce.dart';
import 'package:evantez/src/controller/auth/auth_controller.dart';
import 'package:evantez/src/controller/resources/employee/add_employee_controller.dart';
import 'package:evantez/src/controller/resources/employee/employee_controller.dart';
import 'package:evantez/src/view/core/widgets/custom_back_btn.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_list_view/widgets/employee_filter.dart';
import 'package:evantez/src/view/view/admin/resouces/employee/employee_list_view/widgets/employee_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/themes/colors.dart';
import '../../../../../core/themes/typography.dart';
import '../../../../../core/widgets/custom_textfield.dart';

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, kSize),
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Column(
          children: [
            SizedBox(
              height: kSize.height * 0.032,
            ),
            searchField(context, kSize),
            SizedBox(
              height: kSize.height * 0.028,
            ),
            employeeList(context, kSize),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context, Size kSize) {
    final empAddcontroller = context.watch<AddEmployeeController>();
    final auth = context.watch<AuthController>();
    return AppBar(
      elevation: 0,
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        AppStrings.employeeListText,
        style: AppTypography.poppinsSemiBold.copyWith(),
      ),
      actions: [
        IconButton(
            onPressed: () async {
              await empAddcontroller.resetData();
              empAddcontroller.employee.user = auth.userId;
              await empAddcontroller.employeeTypesData(
                  token: auth.accesToken ?? '');
              await empAddcontroller.employeeIdList(
                  token: auth.accesToken ?? '');
              if (context.mounted) {
                Navigator.pushNamed(
                    context, RouterConstants.addEmployeeViewRoute);
              }
            },
            icon: SvgPicture.asset(
              AppImages.addCircle,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ))
      ],
    );
  }

  Widget searchField(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeesController>();
    final auth = context.watch<AuthController>();
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.baseBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: CustomTextField(
              text: '',
              hintText: AppStrings.searchText,
              onChanged: (value) {
                debounceSearch(value, (String query) async {
                  controller.filterMode.employeeName = value;
                  controller.filterMode.limit = 50;
                  controller.filterMode.offset = 0;
                  controller.employeeLists = [];
                  await controller.employeeList(token: auth.accesToken ?? '');
                });
              },
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 8.0),
                ),
                onPressed: () async {
                  //
                  showModalBottomSheet(
                      backgroundColor: AppColors.accentDark,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppConstants.basePadding),
                              topRight: Radius.circular(
                                AppConstants.basePadding,
                              ))),
                      context: context,
                      builder: (context) {
                        return EmployeeFilter();
                      }).then((value) {
                    if (value) {
                      controller.employeeList(token: auth.accesToken!);
                    }
                  });
                  // EmployeeFilter(context).show();
                },
                child: SvgPicture.asset(
                  AppImages.filter,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                )),
          )
        ],
      ),
    );
  }

  Widget employeeList(BuildContext context, Size kSize) {
    final controller = context.watch<EmployeesController>();
    final auth = context.watch<AuthController>();
    return Expanded(
        child: ListView.builder(
            itemCount: controller.employeeLists.length,
            padding: EdgeInsets.only(
                bottom: kSize.height * 0.08,
                left: AppConstants.baseBorderRadius,
                right: AppConstants.baseBorderRadius),
            itemBuilder: (context, index) {
              return InkWell(
                highlightColor: AppColors.transparent,
                splashColor: AppColors.transparent,
                onTap: () async {
                  //
                  await context
                      .read<EmployeeDetasilController>()
                      .getEmployeeDetails(
                          token: auth.accesToken ?? '',
                          employeeId: controller.employeeLists[index].id ?? 0);
                  if (context.mounted) {
                    Navigator.pushNamed(
                      context,
                      RouterConstants.employeeDetailViewRoute,
                      arguments:  context
                      .read<EmployeeDetasilController>().employeeDetailsModel,
                    ).then((value) async => await controller.employeeList(token: auth.accesToken??""));
                  }
                },
                child: EmployeeTile(
                  index: index,
                ),
              );
            }));
  }
}
