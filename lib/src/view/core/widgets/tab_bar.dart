import 'package:evantez/src/view/core//constants/constants.dart';
import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:evantez/src/view/core//themes/typography.dart';
import 'package:flutter/material.dart';

class CustomTabBarView extends StatefulWidget {
  final Function(int) selectedTap;
  final List<String> tabItems;
  const CustomTabBarView({super.key, required this.selectedTap, required this.tabItems});

  @override
  State<CustomTabBarView> createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> adminTabLabels = ["Ongoing", "Upcoming", "Completed"];

  List<String> boyTabLabels = ['New Events', 'Joined', 'Completed'];

  @override
  void initState() {
    _tabController = TabController(length: widget.tabItems.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0), color: AppColors.secondaryColor.withOpacity(0.4)),
      child: TabBar(
          splashBorderRadius: BorderRadius.circular(AppConstants.basePadding),
          indicator: const BoxDecoration(
            color: AppColors.primaryColor,
          ),
          indicatorColor: AppColors.primaryColor,
          indicatorPadding: EdgeInsets.zero,
          indicatorWeight: 2,
          labelPadding: const EdgeInsets.symmetric(vertical: 8),
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _tabController,
          onTap: (value) {
            widget.selectedTap(value);
          },
          tabs: List.generate(
              widget.tabItems.length,
              (index) => tabTile(
                    kSize,
                    widget.tabItems[index],
                    _tabController.index,
                  ))),
    );
  }

  Widget tabTile(Size kSize, String label, int currentIndex) {
    return Text(
      label,
      style: AppTypography.poppinsMedium.copyWith(fontSize: 14),
    );
  }
}
