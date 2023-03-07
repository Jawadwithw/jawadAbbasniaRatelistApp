import 'package:flutter/material.dart';
import 'package:ratelist/data/const_colors.dart';
import 'package:intl/intl.dart';

class LastUpdateTextWidget extends StatelessWidget {
  DateTime time;
  LastUpdateTextWidget({required this.time});

  @override
  Widget build(BuildContext context) {
    String lastUpdate =
        "Last updatet: ${DateFormat('dd/MM/yyyy - kk:mm').format(time)}";
    return Text(
      lastUpdate,
      style: TextStyle(fontSize: 12, color: ConstColors.lastUpdateTextColor),
      textAlign: TextAlign.center,
    );
  }
}
