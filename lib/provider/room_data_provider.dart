import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  Map<String, dynamic> _roomData = {};
  List<String> _displayElement = ['', '', '', '', '', '', '', '', ''];
  int _filledboxes = 0;
  Player _player1 = Player(
      nickname: '',
      socketId: '',
      points: 0,
      playerType: 'X',
      isReadyToPlay: false);

  Player _player2 = Player(
      nickname: '',
      socketId: '',
      points: 0,
      playerType: 'O',
      isReadyToPlay: false);

  Map<String, dynamic> get roomData => _roomData;
  List<String> get displayElements => _displayElement;
  int get filledboxes => _filledboxes;
  Player get player1 => _player1;
  Player get player2 => _player2;

  void updateRoomData(Map<String, dynamic> data) {
    _roomData = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player2Data) {
    _player2 = Player.fromMap(player2Data);
    notifyListeners();
  }

  void updateDisplayElements(int index, String choice) {
    _displayElement[index] = choice;
    _filledboxes += 1;
    notifyListeners();
  }

  void resetFilledboxes() {
    for (int i = 0; i < displayElements.length; i++) {
      displayElements[i] = '';
    }
    _filledboxes = 0;
  }
}
