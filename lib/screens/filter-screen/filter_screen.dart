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
            Consumer<FilterProvider>(builder: (context, filterProvider, child) {
              return Container(
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)
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
                            style: TextStyle(
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
            })
          ],
        ),
      ),
    );
  }
}
