import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordForm extends GetView<ProfileController> {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.changePasswordKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("mb028".tr, style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              controller.profile?.loginType == 0
                  ? Obx(
                    () => TextFormField(
                      obscureText: !controller.hidePassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      initialValue: "",
                      validator: (value) {
                        if (value == null) {
                          return "mb029".tr;
                        }
                        return null;
                      },
                      onChanged:
                          (value) =>
                              controller.changePasswordModel.oldPassword =
                                  value,
                      onFieldSubmitted: (val) {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.hidePassword.value =
                                !controller.hidePassword.value;
                          },
                          icon: Icon(
                            controller.hidePassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        hintText: "mb030".tr,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                  : SizedBox(),
              SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return "mb029".tr;
                  }
                  return null;
                },
                onChanged:
                    (value) =>
                        controller.changePasswordModel.newPassword = value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  hintText: "mb031".tr,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null) {
                    return "mb029".tr;
                  }
                  if (value != controller.changePasswordModel.newPassword) {
                    return "mb032".tr;
                  }
                  return null;
                },
                onChanged:
                    (value) =>
                        controller.changePasswordModel.newPasswordConfirme =
                            value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  hintText: "mb033".tr,
                  border: OutlineInputBorder(),
                ),
              ),
              Obx(() {
                if (controller.updateProfileLoading.value) {
                  return LinearProgressIndicator();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: BorderSide(color: Colors.red), // Kenarlık
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Köşe yuvarlaklığı
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text("gl007".tr),
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await controller.changePassword();
                      },
                      child: Text("gl008".tr),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
