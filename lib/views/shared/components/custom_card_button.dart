import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData iconData;
  final String title;
  final String? desc;
  const CustomCardButton(
      {super.key,
      required this.onPressed,
      required this.iconData,
      required this.title,
      this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: Get.size.width * 0.6,
        height: 200,
        child: Card(
          color: Get.theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 60,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                desc != null
                    ? Row(
                        children: [
                          Icon(
                            Icons.warning_amber_outlined,
                            color: Colors.amber,
                          ),
                          Expanded(
                            child: Text(
                              desc!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
