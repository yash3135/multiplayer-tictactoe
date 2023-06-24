class Player {
  final String nickname;
  final String socketId;
  final double points;
  final String playerType;
  final bool isReadyToPlay;

  Player({
    required this.nickname,
    required this.socketId,
    required this.points,
    required this.playerType,
    required this.isReadyToPlay,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
      'isReadyToPlay': isReadyToPlay,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      nickname: map['nickname'] ?? '',
      socketId: map['socketId'] ?? '',
      points: map['points']?.toDouble() ?? 0.0,
      playerType: map['playerType'] ?? '',
      isReadyToPlay: map['isReadyToPlay'] ?? false,
    );
  }

  Player copyWith({
    String? nickname,
    String? socketId,
    double? points,
    String? playerType,
    bool? isReadyToPlay,
  }) {
    return Player(
      nickname: nickname ?? this.nickname,
      socketId: socketId ?? this.socketId,
      points: points ?? this.points,
      playerType: playerType ?? this.playerType,
      isReadyToPlay: isReadyToPlay ?? this.isReadyToPlay,
    );
  }
}
