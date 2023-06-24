import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/widgets/custom_loadingscreen.dart';
import 'package:tictactoe/widgets/custom_snackbar.dart';

void customDailogueBox(BuildContext context, String message) {
  final SocketMethods socketMethods = SocketMethods();
  RoomDataProvider roomDataProvider =
      Provider.of<RoomDataProvider>(context, listen: false);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Center(
            child: Text(message),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  socketMethods.playerReady(roomDataProvider.roomData['_id'],
                      socketMethods.socketClient.id);
                  Navigator.pop(context);
                },
                child: const Text("Play again"))
          ],
        );
      }).then((value) => {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return const CustomLoadingDailogue();
          },
        )
      });
}
