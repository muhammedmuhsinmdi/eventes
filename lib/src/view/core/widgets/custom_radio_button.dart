import 'package:evantez/src/view/core//themes/colors.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelected;
  CustomRadioButton({super.key, required this.items, required this.onSelected});

  final ValueNotifier<int> selectedType = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: selectedType,
        builder: (context, value, child) {
          return Wrap(
            children: List.generate(
                items.length,
                (index) => InkWell(
                      highlightColor: AppColors.transparent,
                      splashColor: AppColors.transparent,
                      onTap: () {
                        selectedType.value = index;
                        onSelected(items[selectedType.value]);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(right: kSize.width * 0.02),
                            height: kSize.height * 0.018,
                            width: kSize.height * 0.018,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: selectedType.value == index ? 3 : 1,
                              ),
                              color: selectedType.value == index
                                  ? AppColors.secondaryColor
                                  : AppColors.statusPending,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: kSize.width * 0.032),
                            child: Text(items[index]),
                          )
                        ],
                      ),
                    )),
          );
        });
  }
}
