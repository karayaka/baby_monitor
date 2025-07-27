import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/components/on_live_comonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class DevicePage extends GetView<DeviceController> {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mb010".tr),
        actions: [
          IconButton(
            onPressed: () => controller.refreshDevice(),
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Obx(
            () =>
                controller.deviceListLoaing.value
                    ? LinearProgressIndicator()
                    : Container(),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getDevices();
        },
        child: Obx(
          () => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.deviceList.length,
            itemBuilder: (context, index) {
              var device = controller.deviceList[index];
              if (controller.canDeleteDevice(device.userID ?? "")) {
                return Slidable(
                  key: ValueKey(index),
                  endActionPane: ActionPane(
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          controller.showConfirmeDialog(
                            title: "mb011".tr,
                            message: "mb012".tr,
                            () {
                              controller.deleteDevice(device.id ?? "");
                            },
                          );
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Sil',
                      ),
                    ],
                  ),
                  child: _drawCard(device),
                );
              }
              return _drawCard(device);
            },
          ),
        ),
      ),
    );
  }

  Card _drawCard(DeviceListModel item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Get.theme.primaryColor,
      child: Row(children: _getRow(item)),
    );
  }

  List<Widget> _getRow(DeviceListModel item) {
    List<Widget> w = [
      Expanded(
        child: ListTile(
          onTap: () {
            if (controller.showWatchButon(item.id ?? "")) {
              Get.toNamed(
                RouteConst.viewerScrean,
                arguments: {"deviceId": item.id},
              );
            }
          },
          title: Text(
            item.deviceName ?? "",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "${item.userName} ${item.userSurname}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ];
    if (controller.showWatchButon(item.id ?? "")) {
      w.add(
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: OnLiveComonent(),
        ),
      );
    }
    return w;
  }
}
