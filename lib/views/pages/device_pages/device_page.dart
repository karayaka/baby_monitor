import 'package:baby_monitor/data/controllers/device_controller.dart';
import 'package:baby_monitor/models/device_models/device_list_model.dart';
import 'package:baby_monitor/routing/route_const.dart';
import 'package:baby_monitor/views/pages/device_pages/components/on_live_comonent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
          preferredSize: Size.fromHeight(32.0),
          child: Obx(
            () =>
                controller.deviceListLoaing.value
                    ? LinearProgressIndicator()
                    : controller.isTopAdLoaded.value
                    ? SizedBox(
                      height: controller.topBannerAd?.size.height.toDouble(),
                      width: controller.topBannerAd?.size.width.toDouble(),
                      child: AdWidget(ad: controller.topBannerAd!),
                    )
                    : SizedBox(),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isBottomLoaded.value) {
          return SizedBox(
            height: controller.bottomBannerAd?.size.height.toDouble(),
            width: controller.bottomBannerAd?.size.width.toDouble(),
            child: AdWidget(ad: controller.bottomBannerAd!),
          );
        } else {
          return const SizedBox(height: 8);
        }
      }),
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
                            confirmeText: "gl010",
                            () {
                              controller.deleteDevice(device.id ?? "");
                            },
                          );
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'gl010'.tr,
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
