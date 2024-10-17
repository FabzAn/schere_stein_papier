enum GameAction {
  schere,
  stein,
  papier;

  String get emoji => switch (this) {
        schere => "✌️🏻",
        stein => "✊🏻",
        papier => "✋🏻",
      };
}

class GameState {
  int computerScore = 0;
  int playerScore = 0;
  GameAction? computerAction;
  GameAction? playerAction;
}
