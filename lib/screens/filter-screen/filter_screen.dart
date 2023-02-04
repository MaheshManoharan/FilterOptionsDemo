import 'package:filter_options_demo/provider/filter_provider.dart';
import 'package:filter_options_demo/utils/color_resources.dart';
import 'package:filter_options_demo/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/app_bar_widget.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String _sortValue = 'nearest_to_me';

  @override
  void initState() {
    // TODO: implement initState
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
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Theme(
                        data: ThemeData().copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          title: Text(
                            filterItem.name,
                            style: const TextStyle(
                              color: ColorResources.TEXT_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                                itemCount: filterItem.taxonomies.length,
                                itemBuilder: ((context, index) {
                                  final taxonomyItem =
                                      filterItem.taxonomies[index];
                                  return RadioListTile(
                                    title: Text(taxonomyItem.name!),
                                      value: taxonomyItem.name,
                                      groupValue: null,
                                      onChanged: null);
                                }))
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
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
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
