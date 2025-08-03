import 'package:baby_monitor/core/base_components/timer_components/down_timer_component.dart';
import 'package:baby_monitor/core/enums/row_message_type.dart';
import 'package:baby_monitor/data/controllers/profile_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/shared/components/form_message_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProfileWarningUi extends GetView<ProfileController> {
  const DeleteProfileWarningUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DownTimerComponent(label: "mb034".tr, onTimeEnd: () => Get.back()),
            SizedBox(height: 16),
            Text(
              "gl009".tr,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text("mb035".tr, softWrap: true),
            SizedBox(height: 5),
            Text("mb036".tr, softWrap: true),
            TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(RouteConst.deviceList);
              },
              child: Text("mb037".tr),
            ), //TODO uygulamalrım sayfası gelince güncellenecek
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
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      await controller.deleteProfile();
                    },
                    child: Text("gl010".tr),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
