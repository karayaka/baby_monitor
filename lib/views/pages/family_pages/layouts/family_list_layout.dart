import 'package:baby_monitor/data/controllers/family_controller.dart';
import 'package:baby_monitor/models/family_models/family_member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class FamilyListLayout extends GetView<FamilyController> {
  const FamilyListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getFamily();
      },
      child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.familyModel.value.members?.length ?? 0,
          itemBuilder: (context, i) {
            var item = controller.familyModel.value.members?[i];
            if (controller.canLeaveFromMaily(item?.userID ?? "")) {
              return Slidable(
                  key: ValueKey(i),
                  endActionPane:
                      ActionPane(motion: const BehindMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        controller.showConfirmeDialog(
                            title:
                                "Aileden Ayrılmak İstdiğinizden Eminmisiniz?",
                            message:
                                "Aileden Ayrıldığınıza Çihaz Bağlantılarıda Kopar!",
                            () {
                          controller.leaveFamily(item?.id ?? "");
                        });
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.logout_outlined,
                      label: 'Ayrıl',
                    ),
                  ]),
                  child: _drawCard(item));
            }
            return _drawCard(item);
          }),
    );
  }

  Card _drawCard(FamilyMemberModel? item) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: Get.theme.primaryColor,
      child: ListTile(
        title: Text(
          "${item?.memberName ?? ""} ${item?.memberSurname}",
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(_getBirdDate(item?.birdDate),
            style: TextStyle(color: Colors.white)),
      ),
    );
  }

  String _getBirdDate(DateTime? birdDate) {
    if (birdDate == null) {
      return "";
    } else {
      return birdDate.toIso8601String();
    }
  }
}
