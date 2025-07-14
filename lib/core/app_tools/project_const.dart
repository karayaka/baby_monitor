import 'package:dio/dio.dart';

class ProjectConst {
  static const SESSION_CONTS = "CAGNAZ_APP_SESSION";
  static const DEVICE_TOKEN_CONTS = "CAGNAZ_APP_DEVICE_TOKEN";
  static const REMEMBER_ME = "CAGNAZ_APP_REMEMBER_ME";
  static const APP_KEY = "apikey olak zorunda her istekde";
  static const NOISE_METER_DEB = "NOISE_METER_DEB";
  static const BACKGROUND_ROUTE = "BACKGROUNG_ROUTE";
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
  //Bağlantı koptuğunda bu method çağrılacak
  static const closeConnection = "ConnectionClosed";
}

class WebrtcConnectionConst {
  static const config = {
    "iceServers": [
      {"urls": "stun:stun.relay.metered.ca:80"},
      {
        "urls": "turn:us-east.relay.metered.ca:80",
        "username": "5bd7dda427cc7c367a6303f3",
        "credential": "noUoSsqd//7KHSTD",
      },
      {
        "urls": "turn:us-east.relay.metered.ca:80?transport=tcp",
        "username": "5bd7dda427cc7c367a6303f3",
        "credential": "noUoSsqd//7KHSTD",
      },
      {
        "urls": "turn:us-east.relay.metered.ca:443",
        "username": "5bd7dda427cc7c367a6303f3",
        "credential": "noUoSsqd//7KHSTD",
      },
      {
        "urls": "turns:us-east.relay.metered.ca:443?transport=tcp",
        "username": "5bd7dda427cc7c367a6303f3",
        "credential": "noUoSsqd//7KHSTD",
      },
    ],
  };
  static const URL =
      "https://baby_monitor.metered.live/api/v1/turn/credentials?apiKey=110e7c0d3e74a163413b84766345b4609582&region=us_east";
}

//Project storage password Kara.531531
/*
 keytool -genkey -v -keystore ~/baby_monitor_key.jks -keyalg RSA \
         -keysize 2048 -validity 10000 -alias anroiddebugkey
*/
