import 'dart:async';
import 'dart:developer';
import 'package:developine_app/core/bloc/network_cubit.dart';
import 'package:developine_app/core/bloc/network_state.dart';
import 'package:developine_app/core/layout/colored_safearea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/const/route_constants.dart';
import '../../core/routing/routes.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => RouteNavigator.pushRepalcementNamed(
            routeName: RoutesList.loginRoute));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredSafeArea(
      color: Colors.white,
      showBanner: false,
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: BlocConsumer<NetworkCubit, NetworkState>(
            builder: (BuildContext context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Icon(
                  Icons.download_for_offline_outlined,
                  size: 36,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 12,
              ),
              Visibility(
                visible: state is NetworkDisConnectedState,
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 36,
              )
            ],
          );
        }, listener: (context, state) {
          var snackBar = SnackBar(
            content: Text(
              state.message,
              style: TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          log("SplashPageState listener: ${state.message}");
        }),
      ),
    );
  }
}
