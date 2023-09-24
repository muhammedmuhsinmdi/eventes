import 'package:evantez/src/view/view/transactions/new_event/widgets/custom_service_counter.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/widgets/footer_button.dart';

class ServiceBoys extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelected;
  const ServiceBoys({super.key, required this.items, required this.onSelected});

  @override
  State<ServiceBoys> createState() => _ServiceBoysState();
}

class _ServiceBoysState extends State<ServiceBoys> {
  List<String> serviceItems = [];

  ValueNotifier<int> serviceBoysCount = ValueNotifier<int>(0);

  @override
  void initState() {
    serviceItems.addAll(widget.items);
    serviceBoysCount.value = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return SizedBox(
      width: kSize.width,
      child: ValueListenableBuilder(
          valueListenable: serviceBoysCount,
          builder: (context, value, child) {
            return Column(
              children: List.generate(
                serviceBoysCount.value,
                (index) => serviceBoysCount.value == index + 1
                    ? serviceBoysCount.value >= serviceItems.length
                        ? const SizedBox()
                        : FooterButton(
                            fillColor: AppColors.transparent,
                            label: "Add +",
                            onTap: () {
                              widget.onSelected(serviceItems);
                              if (serviceBoysCount.value <= serviceItems.length) {
                                serviceBoysCount.value++;
                              }
                            })
                    : CustomServiceCounter(
                        label: "Service Boys",
                        items: serviceItems,
                      ),
              ),
            );
          }),
    );
  }

  changeListCount() {}
}
