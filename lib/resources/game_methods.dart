import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/widgets/custom_dailoguebox.dart';
import 'package:tictactoe/widgets/custom_loadingscreen.dart';
import 'package:tictactoe/widgets/custom_snackbar.dart';

class GameMethods {
  checkWinnner(BuildContext context, Socket socketClient) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';
    List winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var postion in winningPositions) {
      if (roomDataProvider.displayElements[postion[0]] ==
              roomDataProvider.displayElements[postion[1]] &&
          roomDataProvider.displayElements[postion[0]] ==
              roomDataProvider.displayElements[postion[2]] &&
          roomDataProvider.displayElements[postion[0]] != '') {
        winner = roomDataProvider.displayElements[postion[0]];
      } else if (roomDataProvider.filledboxes == 9) {
        winner = '';
        // showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (context) {
        //     return CustomLoadingDailogue();
        //   },
        // );
        // Future.delayed(Duration(seconds: 3)).then(
        //   (value) {
        //     clearBoard(context);
        //   },
        // );
        customDailogueBox(context, '${roomDataProvider.player1.nickname} won!');
      }
    }
    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        socketClient.emit('winner', {
          'winerSocketId': roomDataProvider.player1.socketId,
          'roomId': roomDataProvider.roomData['_id']
        });
        // showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (context) {
        //     return CustomLoadingDailogue();
        //   },
        // );
        // Future.delayed(Duration(seconds: 3)).then(
        //   (value) {
        //     clearBoard(context);
        //   },
        // );
        customDailogueBox(context, '${roomDataProvider.player1.nickname} won!');
      } else {
        socketClient.emit('winner', {
          'winerSocketId': roomDataProvider.player2.socketId,
          'roomId': roomDataProvider.roomData['_id']
        });
        customDailogueBox(
          context,
          '${roomDataProvider.player2.nickname} won!',
        );
        // showDialog(
        //   barrierDismissible: false,
        //   context: context,
        //   builder: (context) {
        //     return CustomLoadingDailogue();
        //   },
        // );
        // Future.delayed(Duration(seconds: 3)).then(
        //   (value) {
        //     clearBoard(context);
        //   },
        // );
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
        Provider.of<RoomDataProvider>(context, listen: false);
    // if (roomDataProvider.player1.isReadyToPlay &&
    //     roomDataProvider.player2.isReadyToPlay) {
    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.resetFilledboxes();
  }
  // }
}
