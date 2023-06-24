import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/resources/socket_methods.dart';

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({super.key});

  @override
  State<TicTacToeBoard> createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListener(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size.height * 0.7, maxWidth: 500),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData['turn']['socketId'] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                _socketMethods.tapGrid(index, roomDataProvider.roomData['_id'],
                    roomDataProvider.displayElements);
              },
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white24)),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: Text(roomDataProvider.displayElements[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                  blurRadius: 40,
                                  color:
                                      roomDataProvider.displayElements[index] ==
                                              'O'
                                          ? Colors.red
                                          : Colors.blue)
                            ])),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
