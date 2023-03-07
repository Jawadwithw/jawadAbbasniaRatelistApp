import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ratelist/data/const_data.dart';
import 'package:ratelist/data/rate_model.dart';

class RateListProvider with ChangeNotifier {
  bool _isLoading = true;
  bool _isSuccess = true;
  List<RateModel> _rateList = [];
  List<RateModel> _preRateModelList = [];
  DateTime _lastUpdate = DateTime.now();
  get getLoading {
    return _isLoading;
  }

  get getRateList {
    return _rateList;
  }

  get getPreRateList {
    return _preRateModelList;
  }

  get getLastUpdate {
    return _lastUpdate;
  }

  get getSuccess {
    return _isSuccess;
  }

  Future<Response<dynamic>> getRates() async {
    String url = ConstData.basiURL + ConstData.rateListPath;

    _preRateModelList = _rateList;

    _rateList = [];
    if (!_isLoading) {
      _isLoading = true;
      notifyListeners();
    }
    var dio = Dio();
    try {
      var response = await dio.get(
        url,
      );
      dynamic decodedRes = jsonDecode(response.data);

      for (var element in decodedRes['rates']) {
        _rateList
            .add(RateModel(symbol: element['symbol'], price: element['price']));
      }

      _isLoading = false;
      _lastUpdate = DateTime.now();
      _isSuccess = response.statusCode == 200;
      notifyListeners();
      return response;
    } on DioError catch (e) {
      print("here error");
      _isLoading = false;
       _isSuccess = false;
      notifyListeners();
      return e.response!;
    }
  }
}
