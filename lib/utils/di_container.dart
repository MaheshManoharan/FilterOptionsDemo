import 'package:filter_options_demo/repository/filter_repo.dart';
import 'package:get_it/get_it.dart';

import '../provider/filter_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerFactory(() => FilterProvider(filterRepo: sl()));
  sl.registerLazySingleton(() => FilterRepo());

}