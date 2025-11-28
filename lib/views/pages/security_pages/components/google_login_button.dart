import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleLoginButton extends StatelessWidget {
  bool isLoading = false;
  Function()? onTab;
  Function()? privacyPage;

  GoogleLoginButton({
    this.onTab,
    this.isLoading = false,
    this.privacyPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return InkWell(
      onTap: () {
        Get.dialog(
          barrierDismissible: false,
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.warning_amber),
                      Text(
                        "Google Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: privacyPage,
                    child: Text(
                      "mb064".tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("mb077".tr),
                  Row(
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
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: onTab,
                        child: Text(
                          "mb046".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ); //Policy onayi gönderilecek ve on
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Get.theme.colorScheme.onSecondary,
        ),
        padding: EdgeInsets.all(10),
        child: Image.asset("assets/icon/google_login.png"),
      ),
    );
  }
}
