import 'package:flutter/material.dart';
import 'package:ratelist/data/const_colors.dart';

class SadPathWidget extends StatelessWidget {
  const SadPathWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.error,
            size: 70,
            color: ConstColors.lastUpdateTextColor,
          ),
          Text(
            "Something goes wrong!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            "Please check your internet connectivity\nFailed to get data!",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
