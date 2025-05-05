import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginDivider extends StatelessWidget {
  const LoginDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: Get.theme.colorScheme.onSecondary,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text("OR"),
        SizedBox(
          width: 8,
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Get.theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
