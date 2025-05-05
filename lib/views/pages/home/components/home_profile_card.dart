import 'package:baby_monitor/core/base_components/image_components/custom_image.dart';
import 'package:baby_monitor/models/security_models/session_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeProfileCard extends StatelessWidget {
  SessionModel? session;
  HomeProfileCard({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    if (session == null) {
      return Container();
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4, left: 6),
            child: SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CustomImage(
                  uri: session?.image,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${session?.name?.toUpperCase()} ${session?.lastName?.toUpperCase()}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(session?.email ?? "", style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      );
    }
  }
}
