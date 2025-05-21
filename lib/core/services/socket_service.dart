import 'package:chat_app/core/helper/shared_pref_helper.dart';
import 'package:chat_app/core/netwoking/api_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  Future<void> initSocket() async {
    String token = await SharedPrefHelper.getSecuredString('token');
    socket = IO.io(
      ApiConstants.baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );
    socket.connect();
    socket.onConnect((_) => print('Socket connected ${socket.id}'));
    socket.onDisconnect((_) => print('Socket disconnected ${socket.id}'));
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }

  IO.Socket getSocket() => socket;
}

