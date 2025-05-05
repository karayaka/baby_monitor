import 'package:baby_monitor/data/controllers/family_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class JoinFamilyLayout extends GetView<FamilyController> {
  JoinFamilyLayout({super.key});
  bool onDedect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aileye Katıl"),
      ),
      body: Obx(() {
        if (controller.familyLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _drawScanner();
        }
      }),
    );
  }

  Stack _drawScanner() {
    return Stack(
      children: [
        MobileScanner(onDetect: _handleBarcode),
        Center(
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.greenAccent, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    print(barcodes.barcodes.firstOrNull?.displayValue);
    if (barcodes.barcodes.firstOrNull != null && !onDedect) {
      onDedect = true;
      controller.joinFamily(barcodes.barcodes.firstOrNull?.displayValue ?? "");
    }
  }
}
