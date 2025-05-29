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
    'iceServers': [
      {
        "url": "stun:global.stun.twilio.com:3478",
        "urls": "stun:global.stun.twilio.com:3478",
      },
      {
        "credential": "r2EfFv93Q73/0aPVwxeaNg5YaVd8piMKdLG+76CwaMY=",
        "url": "turn:global.turn.twilio.com:3478?transport=tcp",
        "urls": "turn:global.turn.twilio.com:3478?transport=tcp",
        "username":
            "b5053e7669535ac3eba0aac0365fd7a22482887051cec15b1c5261e964ededc2",
      },
      {
        "credential": "r2EfFv93Q73/0aPVwxeaNg5YaVd8piMKdLG+76CwaMY=",
        "url": "turn:global.turn.twilio.com:3478?transport=udp",
        "urls": "turn:global.turn.twilio.com:3478?transport=udp",
        "username":
            "b5053e7669535ac3eba0aac0365fd7a22482887051cec15b1c5261e964ededc2",
      },
      {
        "credential": "r2EfFv93Q73/0aPVwxeaNg5YaVd8piMKdLG+76CwaMY=",
        "url": "turn:global.turn.twilio.com:443?transport=tcp",
        "urls": "turn:global.turn.twilio.com:443?transport=tcp",
        "username":
            "b5053e7669535ac3eba0aac0365fd7a22482887051cec15b1c5261e964ededc2",
      },
    ],
  };
}

//Project storage password Kara.531531
/*
 keytool -genkey -v -keystore ~/baby_monitor_key.jks -keyalg RSA \
         -keysize 2048 -validity 10000 -alias anroiddebugkey
*/
