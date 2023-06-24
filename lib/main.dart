import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/provider/room_data_provider.dart';
import 'package:tictactoe/screens/create_room_screen.dart';
import 'package:tictactoe/screens/game_screen.dart';
import 'package:tictactoe/screens/join_room_screen.dart';
import 'package:tictactoe/utils/Colors.dart';
import 'screens/main_menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Tic Tac Toe',
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
        home: const MainMenuscreen(),
        routes: {
          MainMenuscreen.routeName: (context) => const MainMenuscreen(),
          CreateRoomscreen.routename: (context) => const CreateRoomscreen(),
          JoinRoomScreen.routename: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuscreen.routeName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
