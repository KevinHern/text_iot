// Basic Imports
import 'package:flutter/material.dart';
import 'package:text_iot/data/repositories/esp_text_management_impl.dart';

// Screens
import 'form/form_screen.dart';

class MainScreen extends StatelessWidget {
  static const double spacing = 8.0;
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            'Proyecto',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: spacing * 5,
                  horizontal: MediaQuery.of(context).size.width * 0.10),
              child: ESPTextFormScreen(
                repository: ESPTextManagementImpl(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
