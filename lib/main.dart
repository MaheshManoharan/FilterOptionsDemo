import 'package:filter_options_demo/provider/filter_provider.dart';
import 'package:filter_options_demo/screens/filter-screen/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/di_container.dart' as di;

Future<void> main() async {

  await di.init();
  
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => di.sl<FilterProvider>()),
          ),
        ],
        child: MyApp(),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: FilterScreen(),
    );
  }
}
