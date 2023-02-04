import 'package:filter_options_demo/repository/filter_repo.dart';
import 'package:flutter/cupertino.dart';

import '../model/response/filter_model.dart';

class FilterProvider extends ChangeNotifier {
  FilterRepo filterRepo;

  FilterProvider({required this.filterRepo});

  late List<Datum> data;
  
  late List<Taxonomy> cusineTaxonomies;
  late String cuisineHeading;
  
  late List<Taxonomy> suitableDietsTaxonomies;
  late  String suitableDietsHeading;

  late List<Taxonomy> experienceTaxonomies;
  late String experienceHeading;

  late List<Taxonomy> mealPeriodsTaxonomies;
  late String mealPeriodHeading;

  late List<Taxonomy> dressCodesTaxonomies;
  late String dressCodeHeading;

  late List<Taxonomy> neighbourHoodsTaxonomies;
  late String neighbourhoodHeading;

  late List<Taxonomy> sortByTaxonomies;
  late String sortHeading;

  late List<Taxonomy> priceRangeTaxonomies;
  late String priceRangeHeading;




  Future<void> getFilterData() async {
//this need not to be async method, 
//assumes it from api.    
    String jsonData = await filterRepo.getFilterData();
    print('jsonData $jsonData');
    final filterModel = filterModelFromJson(jsonData.toString());

    data = filterModel.data;

    cuisineHeading = data[0].name;
    cusineTaxonomies = data[0].taxonomies;

    suitableDietsTaxonomies = data[1].taxonomies;
    suitableDietsHeading  = data[1].name;

    experienceTaxonomies = data[2].taxonomies;
    experienceHeading = data[2].name;

    mealPeriodsTaxonomies = data[3].taxonomies;
    mealPeriodHeading = data[3].name;

    dressCodesTaxonomies = data[4].taxonomies;
    dressCodeHeading = data[4].name;

    neighbourHoodsTaxonomies = data[5].taxonomies;
    neighbourhoodHeading = data[5].name;

    sortByTaxonomies = data[6].taxonomies;
    sortHeading = data[6].name;

    priceRangeTaxonomies = data[7].taxonomies;
    priceRangeHeading = data[7].name;

    notifyListeners();

  }
}
