import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ratelist/data/const_colors.dart';
import 'package:ratelist/data/const_data.dart';
import 'package:ratelist/data/rate_model.dart';
import 'package:ratelist/providers/ratelist_provider.dart';
import 'package:ratelist/widgets/loading_shimmer.dart';
import 'package:ratelist/widgets/sad_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

class RateListWidget extends StatefulWidget {
  const RateListWidget({super.key});

  @override
  State<RateListWidget> createState() => _RateListWidgetState();
}

class _RateListWidgetState extends State<RateListWidget> {
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RateListProvider rateListProvider =
        Provider.of<RateListProvider>(context, listen: false);
    rateListProvider.getRates().then((value) {
      _timer = Timer.periodic(const Duration(minutes: 2), (timer) {
        rateListProvider.getRates();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  String generateItemTitle(String src, String divider) {
    String newStr = '';
    int step = 3;
    for (int i = 0; i < src.length; i += step) {
      newStr += src.substring(i, math.min(i + step, src.length));
      if (i + step < src.length) newStr += divider;
    }
    return newStr;
  }

  @override
  Widget build(BuildContext context) {
    RateListProvider provider =
        Provider.of<RateListProvider>(context, listen: true);

    return 
    provider.getSuccess?
    ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: provider.getLoading ? 7 : provider.getRateList.length,
      itemBuilder: (context, index) {
        late bool higherOrEql;
        if (!provider.getLoading) {
          double currentPrice =
              (provider.getRateList[index] as RateModel).price;

          double prePrice = provider.getPreRateList.isNotEmpty
              ? provider.getPreRateList[index].price
              : 0;

          higherOrEql = currentPrice > prePrice ||
              currentPrice == prePrice ||
              provider.getPreRateList.isEmpty;
        }

        return Container(
            height: 70,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ConstColors.itemBackgroundColor),
            child: provider.getLoading
                ? const LoadingShimmer()
                : Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 27, top: 13, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "${ConstData.imageAssetPath}${(provider.getRateList[index] as RateModel).symbol}.png",
                              height: 44,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Text(
                                generateItemTitle(
                                    (provider.getRateList[index] as RateModel)
                                        .symbol,
                                    "/"),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              (provider.getRateList[index] as RateModel)
                                  .price
                                  .toStringAsFixed(4),
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      higherOrEql ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              higherOrEql
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: higherOrEql ? Colors.green : Colors.red,
                            )
                          ],
                        ),
                      ],
                    )));
      },
    ):SadPathWidget();
  }
}
