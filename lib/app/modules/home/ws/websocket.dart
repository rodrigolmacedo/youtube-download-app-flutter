import 'dart:async';
import 'dart:convert';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

const WSS_CONNECTION = 'ws://192.168.1.139:8080/broadcast';

class WebSs {
  StompClient stompClient;

  WebSs() {
    init().then((client) {
      stompClient = client;
      stompClient.activate();
    });
  }

  final StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>();
  Future<StompClient> init() async {
    return StompClient(
        config: StompConfig(
      url: WSS_CONNECTION,
      // onConnect: onConnect(client, frame),
      onWebSocketError: (dynamic error) => print(error.toString()),
      //stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
      /*webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'}*/
    ));
  }

  dynamic onConnect(StompClient client, StompFrame frame) {
    print("Stomp Connected ...");
    client.subscribe(destination: '/topic/messages', callback: acallBack);
  }

  dynamic acallBack(StompFrame frame) {
    print(json.decode(frame.body));
    Map<String, dynamic> corpo = json.decode(frame.body);
    streamController.add(corpo);
    print(corpo);
  }

  dispose() {
    stompClient.deactivate();
    streamController.close();
  }
}
