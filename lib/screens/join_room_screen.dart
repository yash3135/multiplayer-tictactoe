import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routename = "/JoinRoom";
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayerStateListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(
                  shadows: [BoxShadow(blurRadius: 40, color: Colors.blue)],
                  text: "Join Room",
                  fontsize: 70),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomeTextField(
                  controller: _nameController, hinttext: "Enter your Nickname"),
              SizedBox(
                height: size.height * 0.03,
              ),
              CustomeTextField(
                  controller: _gameIdController, hinttext: "Enter Game ID"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    _socketMethods.joinRoom(
                        _nameController.text, _gameIdController.text);
                  },
                  text: "Join")
            ],
          ),
        ),
      ),
    );
  }
}
