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
    serviceBoysCount.value = 1;
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
              children: [
                Column(
                  children: List.generate(
                    serviceItems.length,
                    (index) => CustomServiceCounter(
                      label: "Service Boys",
                      items: serviceItems,
                    ),
                  ),
                ),
                FooterButton(
                    fillColor: AppColors.transparent,
                    label: "Add +",
                    onTap: () {
                      if (serviceBoysCount.value <= serviceItems.length) {
                        widget.onSelected(serviceItems);
                        serviceBoysCount.value++;
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Max Limit Reached')),
                        );
                      }
                    })
              ],
            );
          }),
    );
  }

  changeListCount() {}
}
