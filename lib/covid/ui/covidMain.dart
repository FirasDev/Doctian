import 'package:hello_world/covid/repositories/data_repository.dart';
import 'package:hello_world/covid/services/api.dart';
import 'package:hello_world/covid/services/api_service.dart';
import 'package:hello_world/covid/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/covid/ui/constant.dart';

void main() async {
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  runApp(Covid());
}

class Covid extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
      ),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: Dashboard(),
    ),
    );
  }
}
