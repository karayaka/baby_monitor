import 'package:baby_monitor/data/controllers/home_controller.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/components/on_live_comonent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/iconnection.dart';

class OnStramDeviceCard extends GetView<HomeController> {
  const OnStramDeviceCard({super.key});
  @override
  Widget build(BuildContext context) {
    if (!controller.hasStreamedDevice()) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getElemest(),
    );
  }

  List<Widget> _getElemest() {
    List<Widget> list = [
      Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text("Yayındaki Çihazlar", style: TextStyle(fontSize: 22)),
      ),
      SizedBox(height: 10),
    ];
    var sdevices = controller.getStreamedDevices().toList();
    for (var i = 0; i < sdevices.length; i++) {
      var device = sdevices[i];
      list.add(
        _getCard(
          device.deviceName ?? "",
          "${device.userName} ${device.userSurname}",
          device.id ?? "",
        ),
      );
    }
    return list;
  }

  Widget _getCard(String title, String subTitle, String deviceId) {
    return GestureDetector(
      onTap:
          () => Get.toNamed(
            RouteConst.viewerScrean,
            arguments: {"deviceId": deviceId},
          ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        color: Get.theme.primaryColor,
        child: ListTile(
          leading: OnLiveComonent(),
          title: Text(title, style: TextStyle(color: Colors.white)),
          subtitle: Text(subTitle, style: TextStyle(color: Colors.white)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        ),
      ),
    );
  }
}
