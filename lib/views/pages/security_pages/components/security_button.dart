import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SecurityButton extends StatelessWidget {
  String text;
  void Function() onTab;
  bool isLoading;
  SecurityButton(
      {required this.isLoading,
      required this.onTab,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return InkWell(
        onTap: onTab,
        child: Container(
          decoration: BoxDecoration(
              color: Get.theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(10)),
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ),
      );
    }
  }
}
