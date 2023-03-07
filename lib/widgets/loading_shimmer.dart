import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../data/const_colors.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ConstColors.itemBackgroundColor),
      ),
    );
  }
}
