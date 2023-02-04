import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../provider/filter_provider.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/dimensions.dart';

class SortSectionWidget extends StatelessWidget {
  const SortSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(builder: (context, filterProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_SMALL),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: Text(
                filterProvider.sortHeading,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorResources.TEXT_COLOR,
                  fontSize: 20,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: filterProvider.sortByTaxonomies.length,
              itemBuilder: ((context, index) {
                final sortItem = filterProvider.sortByTaxonomies[index];
                return RadioListTile(
                  activeColor: ColorResources.RADIO_BUTTON_COLOR,
                  value: sortItem.slug,
                  title: Text(
                    sortItem.name.toString(),
                    style: const TextStyle(
                      color: ColorResources.TEXT_COLOR,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  groupValue: filterProvider.sortValue,
                  onChanged: (value) {
                    // setState(() {
                    //   _sortValue = value!;
                    // });
                    filterProvider.updateSortValue(value);
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
