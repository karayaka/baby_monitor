import 'package:baby_monitor/core/base_components/image_components/custom_image.dart';
import 'package:baby_monitor/core/enums/row_message_type.dart';
import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:baby_monitor/views/pages/profile_pages/components/change_password_form.dart';
import 'package:baby_monitor/views/pages/profile_pages/components/delete_profile_warning_ui.dart';
import 'package:baby_monitor/views/shared/components/form_message_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.onSecondary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Obx(
            () =>
                controller.updateProfileLoading.value
                    ? LinearProgressIndicator()
                    : Container(),
          ),
        ),
      ),
      backgroundColor: Get.theme.colorScheme.onSecondary,
      body: Obx(() {
        if (controller.profileLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomImage(uri: controller.profile?.imageUrl),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: controller.profile?.name ?? "",
                  onChanged: (value) => controller.profile?.name = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    hintText: "mb038".tr,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: controller.profile?.surname,
                  onChanged: (value) => controller.profile?.surname = value,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box),
                    hintText: "mb039".tr,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  initialValue: controller.profile?.email,
                  onChanged: (value) => controller.profile?.email = value,
                  readOnly: controller.profile?.isMailConfirm ?? false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "mb040".tr,
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: controller.confirmEmail,
                      icon: Icon(
                        color:
                            controller.profile?.isMailConfirm ?? false
                                ? Colors.green
                                : Colors.red,
                        controller.profile?.isMailConfirm ?? false
                            ? Icons.check
                            : Icons.warning,
                      ),
                    ),
                  ),
                ),
                controller.profile?.isMailConfirm ?? false
                    ? FormMessageRow(
                      type: RowMessageType.success,
                      message: "mb041".tr,
                    )
                    : FormMessageRow(
                      type: RowMessageType.warning,
                      message: "mb042".tr,
                    ),
                SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.dialog(
                        barrierDismissible: false,
                        ChangePasswordForm(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue, // Metin ve ikon rengi
                      side: BorderSide(color: Colors.blue), // Kenarlık
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          3,
                        ), // Yuvarlak köşeler
                      ),
                    ),
                    child: Text(
                      "mb043".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Get.dialog(
                        barrierDismissible: false,
                        DeleteProfileWarningUi(),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red, // Metin ve ikon rengi
                      side: BorderSide(color: Colors.red), // Kenarlık
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          3,
                        ), // Yuvarlak köşeler
                      ),
                    ),
                    child: Text(
                      "mb044".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                Obx(() {
                  if (controller.updateProfileLoading.value) {
                    return LinearProgressIndicator();
                  } else {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onPressed: () => controller.updateProfile(),
                        child: Text("gl008".tr),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
