import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyCard extends StatelessWidget {
  Function()? onTab;
  bool loading = true;
  int memberCount = 0;
  FamilyCard({
    super.key,
    this.onTab,
    this.loading = true,
    this.memberCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        color: Get.theme.primaryColor,
        child: Column(
          children: [
            loading ? LinearProgressIndicator() : Container(),
            ListTile(
              title: Text(
                "mb003".tr,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              subtitle: Text(
                "mb004".tr,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              leading: Icon(Icons.people_alt, color: Colors.white, size: 65),
              trailing: Text(
                memberCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
