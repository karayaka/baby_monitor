import 'package:baby_monitor/core/app_tools/project_validations.dart';
import 'package:baby_monitor/data/controllers/security_controller.dart';
import 'package:baby_monitor/views/pages/security_pages/components/security_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends GetView<SecurityController> {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            initialValue: controller.registerModel.name,
            validator: ProjectValidations.notEmty,
            onChanged: (value) => controller.registerModel.name = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_box),
              hintText: "mb038".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            keyboardType: TextInputType.text,
            validator: ProjectValidations.notEmty,
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
            validator: ProjectValidations.validateEmail,
            onChanged: (value) => controller.registerModel.email = value,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: "mb040".tr,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => TextFormField(
              obscureText: controller.passwordoObscureText.value,
              keyboardType: TextInputType.visiblePassword,
              validator: ProjectValidations.notEmty,
              initialValue: controller.registerModel.password,
              onChanged: (value) => controller.registerModel.password = value,
              onFieldSubmitted: (val) {},
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: controller.showHidePassword,
                  icon: Icon(
                    controller.passwordoObscureText.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                prefixIcon: Icon(Icons.key),
                hintText: "mb045".tr,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 5),
          Obx(
            () => Row(
              children: [
                Checkbox(
                  value: controller.isAcceptancePolicy.value,
                  onChanged: (value) {
                    controller.isAcceptancePolicy.value = value ?? false;
                  },
                ),
                TextButton(
                  onPressed: () => controller.privacyPage(),
                  child: Text("mb064".tr),
                ),
              ],
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
