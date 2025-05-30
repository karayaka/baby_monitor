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
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun.l.google.com:5349'},
      {'urls': 'stun:stun1.l.google.com:3478'},
      {'urls': 'stun:stun1.l.google.com:5349'},
      {'urls': 'stun:stun2.l.google.com:19302'},
      {'urls': 'stun:stun2.l.google.com:5349'},
      {'urls': 'stun:stun3.l.google.com:3478'},
      {
        "url": "stun:global.stun.twilio.com:3478",
        "urls": "stun:global.stun.twilio.com:3478",
      },
      {
        "credential": "UnYcq6VE/8IaZvEXbfemNH/usA4=",
        "url": "relay1.expressturn.com:3480",
        "urls": "relay1.expressturn.com:3480",
        "username": "000000002063957299",
      },
    ],
  };
}

//Project storage password Kara.531531
/*
 keytool -genkey -v -keystore ~/baby_monitor_key.jks -keyalg RSA \
         -keysize 2048 -validity 10000 -alias anroiddebugkey
*/
