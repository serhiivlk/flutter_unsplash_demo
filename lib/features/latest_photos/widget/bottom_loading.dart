import 'package:flutter/material.dart';

class BottomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
