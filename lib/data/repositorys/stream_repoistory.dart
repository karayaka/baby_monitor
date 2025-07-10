import 'dart:io';

import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/local_storage/device_db_manager.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';

class StreamRepoistory extends BaseRepository {
  //signalr bağlantıları strart stream gibi işlemler yapılacak
  late final HubConnection _connection;
  late DeviceDbManager _dbManager;

  StreamRepoistory() {
    var deviceToken = getDeviceToken() ?? "";
    final httpOptions = HttpConnectionOptions(
      accessTokenFactory: () async => (getToken() ?? ""),
      skipNegotiation: true,
      transport: HttpTransportType.WebSockets,
    );
    _connection =
        HubConnectionBuilder()
            .withUrl(
              'https://babymonitor.cagnaz.com/liveStream?deviceId=$deviceToken',
              options: httpOptions,
            )
            .build();
    _dbManager = DeviceDbManager();
  }

  Future<void> connect({
    Function(dynamic)? sendOffer,
    Function(dynamic)? sendCandidate,
    Function(dynamic)? answerOffer,
    Function(dynamic)? answerCandidate,
  }) async {
    if (_connection.state != HubConnectionState.Connected) {
      await _connection.start();
    }
    //_connection.onreconnected(callback)//TODO start stream durumunda ise repoyu çağıran controller startStream metodu yenden çağrılacak
    if (sendOffer != null) {
      _connection.on(HubMethods.sendOffer, (arg) {
        sendOffer(arg);
      });
    }
    if (sendCandidate != null) {
      _connection.on(HubMethods.sendCandidate, (arg) {
        sendCandidate(arg);
      });
    }
    if (answerOffer != null) {
      _connection.on(HubMethods.sendAnswer, (arg) {
        answerOffer(arg);
      });
    }
    if (answerCandidate != null) {
      _connection.on(HubMethods.sendAnswerCandidate, (arg) {
        answerCandidate(arg);
      });
    }
  }

  Future<void> disconnect() async {
    if (_connection.state == HubConnectionState.Connected) {
      await _connection.stop();
    }
  }

  Future<void> startStream() async {
    await _connection.invoke(HubMethods.startStream);
  }

  Future<void> sendStartStreamNotification(String title, String body) async {
    await _connection.invoke(
      HubMethods.sendStartStreamNotification,
      args: [title, body],
    );
  }

  Future<void> callOtherDevice() async {
    await _dbManager.init();
    var device = _dbManager.getFistWhere(
      (d) => d?.deviceId == getDeviceToken(),
    );
    await _connection.invoke(
      HubMethods.startCall,
      args: [device?.deviceName ?? "unknown"],
    ); //TODO tr çevirisi
  }

  Future<void> sendtoCliend(
    String toDeviceId,
    String method,
    dynamic data,
  ) async {
    await _connection.invoke(
      HubMethods.sendToCliend,
      args: [toDeviceId, method, data],
    );
  }
  //Metedred api

  Future<Map<String, dynamic>> fetchIceServers() async {
    final dio = Dio();
    final url =
        'https://baby_monitor.metered.live/api/v1/turn/credentials?apiKey=110e7c0d3e74a163413b84766345b4609582&region=us_east';

    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (
        client,
      ) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final iceServers = response.data;

        // Örnek olarak peerConnection yapılandırmasında kullanabilirsin:
        return {'iceServers': iceServers['iceServers']};
      } else {
        return WebrtcConnectionConst.config;
      }
    } catch (e) {
      return WebrtcConnectionConst.config;
    }
  }
}
