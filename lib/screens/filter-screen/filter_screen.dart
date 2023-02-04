import 'package:filter_options_demo/model/response/filter_model.dart';
import 'package:filter_options_demo/provider/filter_provider.dart';
import 'package:filter_options_demo/utils/color_resources.dart';
import 'package:filter_options_demo/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/filter_item_heading.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _sortValue = 'nearest_to_me';

  List<Taxonomy> selectedTaxonomyList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<FilterProvider>(context, listen: false).getFilterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.BACKGROUND_COLOR,
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Wrap(
                children: selectedTaxonomyList
                    .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: FilterChip(
                          showCheckmark: false,
                          backgroundColor: ColorResources.TOP_BUTTON_COLOR,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          avatar: Center(child: Icon(Icons.close)),
                          label: Text(e.name!),
                          onSelected: (value) {
                            setState(() {
                              selectedTaxonomyList.remove(e);
                            });
                          }),
                    ))
                    .toList(),
              ),
            ),
            _sortSection(),
            Consumer<FilterProvider>(builder: (context, filterProvider, child) {
              return ListView.builder(
                  itemCount: filterProvider.data.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: ((context, index) {
                    final filterItem = filterProvider.data[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Theme(
                        data: ThemeData().copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          title: FilterItemHeading(filterItem: filterItem),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: filterItem.taxonomies.length,
                              itemBuilder: ((context, index) {
                                final taxonomyItem =
                                    filterItem.taxonomies[index];
                                return RadioListTile(
                                  toggleable: true,
                                  activeColor:
                                      ColorResources.RADIO_BUTTON_COLOR,
                                  title: Text(taxonomyItem.name!),
                                  value: taxonomyItem,
                                  groupValue: selectedTaxonomyList
                                          .contains(taxonomyItem)
                                      ? taxonomyItem
                                      : null,
                                  onChanged: (value) {
                                    print("value:$value");
                                    setState(() {
                                      if (selectedTaxonomyList
                                              .contains(value) ||
                                          value == null) {
                                        selectedTaxonomyList
                                            .remove(taxonomyItem);
                                        filterItem.selectedItemCount =
                                            filterItem.selectedItemCount! - 1;
                                      } else {
                                        selectedTaxonomyList.add(value);
                                        filterItem.selectedItemCount =
                                            filterItem.selectedItemCount! + 1;
                                      }
                                      print('selected: $selectedTaxonomyList');
                                    });
                                  },
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  }));
            })
          ],
        ),
      ),
    );
  }

  Consumer<FilterProvider> _sortSection() {
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
            Text(
              filterProvider.sortHeading,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: ColorResources.TEXT_COLOR,
                fontSize: 20,
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
                  groupValue: _sortValue,
                  onChanged: (value) {
                    print('value: $value');
                    setState(() {
                      _sortValue = value!;
                    });
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
