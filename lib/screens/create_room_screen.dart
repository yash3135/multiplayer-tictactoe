import 'package:flutter/material.dart';
import 'package:tictactoe/resources/socket_methods.dart';
import 'package:tictactoe/utils/responsive.dart';
import 'package:tictactoe/widgets/custom_button.dart';
import 'package:tictactoe/widgets/custom_text.dart';
import 'package:tictactoe/widgets/custom_textfield.dart';

class CreateRoomscreen extends StatefulWidget {
  static String routename = "/CreateRoom";
  const CreateRoomscreen({super.key});

  @override
  State<CreateRoomscreen> createState() => _CreateRoomscreenState();
}

class _CreateRoomscreenState extends State<CreateRoomscreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                  text: "Create Room",
                  fontsize: 70),
              SizedBox(
                height: size.height * 0.08,
              ),
              CustomeTextField(
                  controller: _nameController, hinttext: "Enter your Nickname"),
              SizedBox(
                height: size.height * 0.045,
              ),
              CustomButton(
                  onTap: () {
                    _socketMethods.createRoom(_nameController.text);
                  },
                  text: "Create")
            ],
          ),
        ),
      ),
    );
  }
}
