import 'dart:async';

import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:baby_monitor/data/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SendNotifireRepoistory extends BaseRepository {
  Dio? _dio;
  String? _token;
  Timer? _timer;
  late HttpService _service;
  SendNotifireRepoistory() {
    _service = HttpService.instance!;
    var header = {'Accept': '*/*', 'Content-Type': 'application/json'};
    final baseOptions = BaseOptions(
      contentType: Headers.jsonContentType,
      headers: header,
    );

    _dio = Dio(baseOptions);
    start();
  }
  //Bu işlemler sunucu tarafına taşınacak ve signal r istemcileri ile yapılacal
  /*

  public class FirebaseService
{
    public FirebaseService()
    {
        // Bu satır sadece bir kez çağrılmalı (Startup.cs veya Program.cs içinde uygun yer)
        if (FirebaseApp.DefaultInstance == null)
        {
            FirebaseApp.Create(new AppOptions()
            {
                Credential = GoogleCredential.FromFile("firebase-adminsdk.json")
            });
        }
    }

    public async Task SendNotificationAsync(List<string> deviceTokens)
    {
        var message = new MulticastMessage()
        {
            Notification = new Notification()
            {
                Title = "Bebek Ağlıyor",
                Body = "Hemen kontrol et!",
            },
            Data = new Dictionary<string, string>()
            {
                { "type", "call" },
                { "deviceId", "abc123" }
            },
            Tokens = deviceTokens
        };

        var response = await FirebaseMessaging.DefaultInstance.SendMulticastAsync(message);

        Console.WriteLine($"{response.SuccessCount} mesaj gönderildi, {response.FailureCount} hata oluştu.");
    }
}

  */

  void start() {
    const duration = Duration(minutes: 55);

    _timer = Timer.periodic(duration, (timer) {
      _getToken();
    });
  }

  Future _getToken() async {
    try {
      var result = await _service.get(
        "babymonitor/Vault/GetFcmToken",
        null,
        token: (getToken() ?? ""),
      );

      _token = result.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendNotifire(Map<String, Object> data) async {
    try {
      if (_token == null) {
        await _getToken();
      }
      _dio?.options.headers.addAll({"Authorization": "Bearer $_token"});
      await _dio!.post(
        "https://fcm.googleapis.com/v1/projects/babymonitor-2cc90/messages:send",
        data: data,
      );
    } catch (e) {
      rethrow;
    }
  }

  //Live stream başlatılınca çalışacak olan method
  Future<void> startStream(List<String> fcmTokens) async {
    try {
      for (var element in fcmTokens) {
        var data = {
          "message": {
            "token": element,
            "notification": {
              "title":
                  "İzleme Bşaltıldı".tr, //TODO translate işlemleri yapılacak
              "body": "Bir Çihazda İzleme Başatıldı".tr,
            },
          },
        };
        await sendNotifire(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  //Bebek ağladığında haberverip çağrı başlatıcak olan method!
  Future<void> babyCry(String fcmToken, String deviceId) async {
    try {
      var data = {
        "message": {
          "token":
              "cMCYcwkIRXqPnfHlrJNjy5:APA91bGmQhh04KQ-OijopaPUixsZaIjOU7r00rddveWck9879D48sXjpKOID1D7zH7pvFpop_813Qsb1VvJfWSYBtVWOsGcw6whd3ujSwcmPTG6uHe5-C5Y",
          "data": {"type": "call", "deviceId": deviceId},
        },
      };
      await sendNotifire(data);
    } catch (e) {
      rethrow;
    }
  }
}

/*

{
          "message": {
            "token":
                "cMCYcwkIRXqPnfHlrJNjy5:APA91bGmQhh04KQ-OijopaPUixsZaIjOU7r00rddveWck9879D48sXjpKOID1D7zH7pvFpop_813Qsb1VvJfWSYBtVWOsGcw6whd3ujSwcmPTG6uHe5-C5Y",
            "notification": {"title": "aşkım", "body": "başarıcaksın korkma"},
            "data": {"key1": "value1", "key2": "value2"},
          },
        }
        */
//Bu
