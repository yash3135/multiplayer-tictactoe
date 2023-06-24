import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/responsive.dart';
import 'package:tictactoe/views/scoreboard.dart';
import 'package:tictactoe/views/tictactoe_board.dart';
import 'package:tictactoe/views/waitinglobby.dart';
import 'package:tictactoe/widgets/custom_text.dart';

class GameScreen extends StatefulWidget {
  static String routeName = "/GameScreen";
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayerStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.playerReadyListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return Scaffold(
        body: roomDataProvider.roomData['isJoin']
            ? const Responsive(child: WaitingLobby())
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const TicTacToeBoard(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                        shadows: const [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 30,
                              spreadRadius: 5)
                        ],
                        text:
                            ('${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                        fontsize: 18),
                  )
                ],
              )));
  }
}
