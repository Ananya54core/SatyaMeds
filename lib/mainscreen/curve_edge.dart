import 'package:flutter/material.dart';
import 'package:satyameds/utils/constants/colors.dart';
import 'curve_edgedesign.dart';
class TCurvedEdgeWidget extends StatelessWidget {
  const TCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCurvedEdges(),
      child: child,
    );
  }
}

