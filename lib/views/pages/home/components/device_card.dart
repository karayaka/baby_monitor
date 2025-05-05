import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceCard extends StatelessWidget {
  Function()? onTab;
  bool loading = true;
  int deviceCount = 0;
  DeviceCard(
      {super.key, this.onTab, this.loading = true, this.deviceCount = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(12))),
        color: Get.theme.primaryColor,
        child: Column(
          children: [
            loading ? LinearProgressIndicator() : Container(),
            ListTile(
              title: Text(
                "Cihaz Sayısı".tr,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              subtitle: Text(
                "Erişilebilen Cihzlarınız".tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              leading: Icon(
                Icons.devices_other,
                color: Colors.white,
                size: 65,
              ),
              trailing: Text(
                deviceCount.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
