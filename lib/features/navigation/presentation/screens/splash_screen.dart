import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:todoapp/core/widget/waiting_widget.dart';

import '../../../../core/routing/route_paths.dart';
import '../../../../core/utils.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashcreenState();
}

class _SplashcreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initfAsync();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  bool isRtl = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          child: Scaffold(
            resizeToAvoidBottomInset: true, //new line

            body: Center(child: WaitingWidget()),
          ),
        ));
  }

  _initfAsync() async {
    // CallApi();
  }

  goToLogin() async {
    setState(() {
      Utils.popNavigateToFirst(context);
      Utils.pushReplacementNavigateTo(
        context,
        RoutePaths.LogIn,
      );
    });
  }

 }
