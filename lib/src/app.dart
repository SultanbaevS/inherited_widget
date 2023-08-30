import 'package:flutter/material.dart';
import 'package:inherit_lesson/src/widgets/components/app_state_widget.dart';

import 'widgets/store_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const StorePage(),
      ),
    );
  }
}
