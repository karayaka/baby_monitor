import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/views/pages/security_pages/components/security_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassword extends GetView<SecurityController> {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: controller.resetPasswordModel.email,
            onChanged: (value) => controller.resetPasswordModel.email = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "mb040".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => SecurityButton(
              text: "mb050".tr,
              onTab: controller.resetPassword,
              isLoading: controller.resetPasswordLoading.value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: controller.getRegisterTab,
                child: Row(
                  children: [Icon(Icons.arrow_back), Text("mb047".tr)],
                ),
              ),
              TextButton(
                onPressed: controller.getLoginTab,
                child: Row(
                  children: [Text("mb046".tr), Icon(Icons.arrow_forward)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
