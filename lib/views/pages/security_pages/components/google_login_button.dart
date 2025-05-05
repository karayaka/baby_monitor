import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleLoginButton extends StatelessWidget {
  bool isLoading = false;
  Function()? onTab;
  GoogleLoginButton({this.onTab, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return InkWell(
      onTap: onTab,
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20),
              color: Get.theme.colorScheme.onSecondary),
          padding: EdgeInsets.all(10),
          child: Image.asset("assets/icon/google_login.png")),
    );
  }
}
