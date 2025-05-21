import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class ISocketService {
  Future<void> initSocket();
  IO.Socket get socket;
  void dispose();
}


class SocketService implements ISocketService {
  late IO.Socket _socket;

  @override
  IO.Socket get socket => _socket;

  @override
  Future<void> initSocket() async {
    String token = await SharedPrefHelper.getSecuredString('token');
    _socket = IO.io(
      ApiConstants.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    _socket.connect();

    _socket.onConnect((_) => print('Socket connected ${_socket.id}'));
    _socket.onDisconnect((_) => print('Socket disconnected ${_socket.id}'));
  }

  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
  }
}


