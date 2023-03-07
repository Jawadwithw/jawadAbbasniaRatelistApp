import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ratelist/data/const_colors.dart';
import 'package:ratelist/data/const_strings.dart';
import 'package:provider/provider.dart';
import 'package:ratelist/providers/ratelist_provider.dart';
import 'package:ratelist/widgets/last_update_text_widget.dart';
import 'package:ratelist/widgets/rate_list_widet.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ratelist/widgets/sad_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.wifi;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_connectionStatus);
    return Scaffold(
        backgroundColor: ConstColors.backgroundColor,
        body: _connectionStatus == ConnectivityResult.none
            ? const SadPathWidget()
            : Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 24, right: 24, top: 76, bottom: 129),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 24),
                          child: const Text(
                            ConstStrings.homeScreenTitle,
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(child: RateListWidget())
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 44),
                      child: Consumer<RateListProvider>(
                        builder: (context, value, child) {
                          return LastUpdateTextWidget(
                              time: value.getLastUpdate);
                        },
                      ))
                ],
              ));
  }
}
