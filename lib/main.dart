import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:gaffet/screens/login_screen.dart';
import 'package:gaffet/utils/api_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//Version 2.0.0

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  loadads();
  runApp(MyApp());
  disableScreenshots();
}

AppOpenAd? _appOpenAd;

void disableScreenshots() async {
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}

loadads(){
  AppOpenAd.load(
    adUnitId: 'ca-app-pub-3209340835968164/3090288763',
    request: AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) {
        _appOpenAd = ad;
        _appOpenAd!.show();
      },
      onAdFailedToLoad: (error) {
        debugPrint('Ad failed to load: $error');
      },
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String employee='';

  Future<String> login(String payrollId) async {
    try {
      employee = await ApiService.findEmployeeById(payrollId);
  
      return employee.toString();
    } catch (e) {
      print('Error en el login: $e');
      return employee.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(
        onLogin: login,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cerrar'),
          ),
        ],
      );
    },
  );
}