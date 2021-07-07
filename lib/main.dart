import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube/app/app_widget.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ModularApp(
    module: AppModule(),
    child: AppWidget(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
