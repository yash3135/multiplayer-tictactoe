import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/game_methods.dart';
import 'package:tictactoe/resources/socket_methods.dart';

class CustomLoadingDailogue extends StatefulWidget {
  const CustomLoadingDailogue({super.key});

  @override
  State<CustomLoadingDailogue> createState() => _CustomLoadingDailogueState();
}

class _CustomLoadingDailogueState extends State<CustomLoadingDailogue> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      _socketMethods.playerReadyListener(context);
      _socketMethods.endGameListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    bool isready = false;
    isready = roomDataProvider.player1.isReadyToPlay &&
        roomDataProvider.player2.isReadyToPlay;
    if (isready) {
      roomDataProvider.resetFilledboxes();
        Navigator.pop(context);
    }
    return CupertinoAlertDialog(
      content: Center(
        child: Column(
          children: [
            Lottie.network(
                "https://assets2.lottiefiles.com/packages/lf20_eAqEBOw7m9.json"),
            const Text("Waiting for opponent to ready")
          ],
        ),
      ),
    );
  }
}
