import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/views/pages/security_pages/components/security_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends GetView<SecurityController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: controller.registerModel.name,
            onChanged: (value) => controller.registerModel.name = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              hintText: "mb038".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: controller.registerModel.surname,
            onChanged: (value) => controller.registerModel.surname = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              hintText: "mb039".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            initialValue: controller.registerModel.email,
            onChanged: (value) => controller.registerModel.email = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "mb040".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            initialValue: controller.registerModel.password,
            onChanged: (value) => controller.registerModel.password = value,
            onFieldSubmitted: (val) {},
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.key),
              hintText: "mb045".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => SecurityButton(
              text: "mb049".tr,
              onTab: controller.register,
              isLoading: controller.registerLoading.value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: controller.getLoginTab,
                child: Row(
                  children: [Icon(Icons.arrow_back), Text("mb046".tr)],
                ),
              ),
              TextButton(
                onPressed: controller.getForgetPasswordTab,
                child: Row(
                  children: [Text("mb048".tr), Icon(Icons.arrow_forward)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
