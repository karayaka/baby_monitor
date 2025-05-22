import 'package:baby_monitor/core/app_tools/project_const.dart';
import 'package:baby_monitor/data/repositorys/base_repository.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';

class StreamRepoistory extends BaseRepository {
  //signalr bağlantıları strart stream gibi işlemler yapılacak
  late final HubConnection _connection;

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

  Future<void> callOtherDevice(String deviceName) async {
    await _connection.invoke(HubMethods.startCall, args: [deviceName]);
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
}
