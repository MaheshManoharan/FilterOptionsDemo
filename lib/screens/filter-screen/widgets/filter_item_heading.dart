import 'package:flutter/material.dart';

import '../../../model/response/filter_model.dart';
import '../../../utils/color_resources.dart';

class FilterItemHeading extends StatelessWidget {
  const FilterItemHeading({
    Key? key,
    required this.filterItem,
  }) : super(key: key);

  final Datum filterItem;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: "${filterItem.name}",
                 style: TextStyle(
                                color: ColorResources.TEXT_COLOR,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),

          children: [
            if (filterItem.selectedItemCount! > 0)
              TextSpan(
                  text: "   (${filterItem.selectedItemCount})",
                  style: TextStyle(
                    color: ColorResources.RADIO_BUTTON_COLOR,
                    fontWeight: FontWeight.bold,
                  ))
          ]),
    );
  }
}
