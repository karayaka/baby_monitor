import 'dart:convert';

class ProjectConst {
  static const SESSION_CONTS = "CAGNAZ_APP_SESSION";
  static const DEVICE_TOKEN_CONTS = "CAGNAZ_APP_DEVICE_TOKEN";
  static const REMEMBER_ME = "CAGNAZ_APP_REMEMBER_ME";
  static const APP_KEY = "apikey olak zorunda her istekde";
}

class ProjectUrls {
  static const base_url = "https://gate.cagnaz.com/";
  static const AUTH_URL = "https://auth.cagnaz.com/";
  static const BABYMONITOR_URL = "https://babymonitor.cagnaz.com/";
  static const FAMILY_URL = "https://family.cagnaz.com/";
}

class HubMethods {
  static const startStream = "StartStream";
  static const sendStartStreamNotification = "SendStartStreamNotification";
  static const startCall = "StartCall";
  static const sendToCliend = "SendToCliend";
  static const sendOffer = "SendOffer"; //İzleyici gönderecek yayıncı dinleyecek
  static const sendCandidate =
      "SendCandidate"; //İzleyici gönderecek yayıncı dinleyecek
  static const sendAnswer =
      "SendAnswer"; //Yayıncı gönderecek izleyici dinleyecek
  static const sendAnswerCandidate =
      "SendAnswerCandidate"; //Yayıncı gönderecek izleyici dinleyecek
}

class WebrtcConnectionConst {
  static const config = {
    "account_sid": "AC0f888d2bf69790fef945ae0c2ca10a53",
    "date_created": "Mon, 26 May 2025 18:44:20 +0000",
    "date_updated": "Mon, 26 May 2025 18:44:20 +0000",
    "ice_servers": [
      {
        "url": "stun:global.stun.twilio.com:3478",
        "urls": "stun:global.stun.twilio.com:3478",
      },
      {
        "credential": "D2BYSh72PLaOdW7qGA4bU0u7veftT2u8+s8zDB0mw5k=",
        "url": "turn:global.turn.twilio.com:3478?transport=udp",
        "urls": "turn:global.turn.twilio.com:3478?transport=udp",
        "username":
            "4628d84c1999bcbdf906bce85839a9ddf619a521b95b913ea50213e5f1046081",
      },
      {
        "credential": "D2BYSh72PLaOdW7qGA4bU0u7veftT2u8+s8zDB0mw5k=",
        "url": "turn:global.turn.twilio.com:3478?transport=tcp",
        "urls": "turn:global.turn.twilio.com:3478?transport=tcp",
        "username":
            "4628d84c1999bcbdf906bce85839a9ddf619a521b95b913ea50213e5f1046081",
      },
      {
        "credential": "D2BYSh72PLaOdW7qGA4bU0u7veftT2u8+s8zDB0mw5k=",
        "url": "turn:global.turn.twilio.com:443?transport=tcp",
        "urls": "turn:global.turn.twilio.com:443?transport=tcp",
        "username":
            "4628d84c1999bcbdf906bce85839a9ddf619a521b95b913ea50213e5f1046081",
      },
    ],
    "password": "D2BYSh72PLaOdW7qGA4bU0u7veftT2u8+s8zDB0mw5k=",
    "ttl": "86400",
    "username":
        "4628d84c1999bcbdf906bce85839a9ddf619a521b95b913ea50213e5f1046081",
  };
}

//Project storage password Kara.531531
/*
 keytool -genkey -v -keystore ~/baby_monitor_key.jks -keyalg RSA \
         -keysize 2048 -validity 10000 -alias anroiddebugkey
*/
