import 'package:flutter/material.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/utils/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';

class MainMenuscreen extends StatelessWidget {
  static String routeName = "/MainMenu";
  const MainMenuscreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomscreen.routename);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(onTap: () => createRoom(context), text: "Create Room"),
          const SizedBox(
            height: 20,
          ),
          CustomButton(onTap: () => joinRoom(context), text: "Join Room"),
        ],
      ),
    ));
  }
}
