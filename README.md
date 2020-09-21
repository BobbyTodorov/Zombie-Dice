# ZombieDice
DESCRIPTION:

1) CLASS SimpleDie - implements a standart n-sided generic die that can be rolled
      - number of sides
      - [sides]
      - Roll()

2) CLASS ZombieDie : SimpleDie <String> - implements a printable, String 6-sided "Zombie Die" with a color property
      - color
      - PrintZDie()
  
3) CLASS Board - stores and initializes the game's Zombie Dice
      - [13x ZombieDie] 
      - Reset() 
  

4) CLASS Player - implements a standart simple Player unit with name and score
      - name
      - score
      - IncreaseScore(by:Int)
      - ResetScore()
      - GetScore()

5) CLASS ZombieDicePlayer : Player - implements a "Zombie Dice Player" that can operate with Zombie Dice 
      - [3x ZombieDie] - stores the 3x"Drawn" dice //player's hand
      - Draw(count:Int, fromSetOfDice: inout [ZombieDice]) -> [ZombieDice] - Draws (count)xZombieDice from a source (set of ZD)
      - ThrowADie(dieToThrow: ZombieDie) -> String - Throws a ZD and returns the Roll's value
      - ThrowAllDice() -> [String]

6) CLASS GameCore - main game logic; manages scores, board, players, dice, etc.
      - board : Board
      - players : [ZombieDicePlayers]
      - InitializePlayers() - appends "players" with n players and their unique names
      - PrintPlayersScore() - prints all players' score
      - ResetPlayersScore() - resets all players' score to 0
      - GetAnswerYN() - asks the player "yes/no"
      
      - SimulateTurn(playerPlaying : ZombieDicePlayer) - main turn logic and interface
           - drawnZDice = playerPlaying.Draw(numberOfDice: 3, fromSetOfDice: &board.zombieDice)
           - pointsToGain = SimulateTurnThrow(playerPlaying: playerPlaying, diceToThrow: drawnZDice, numberOfWeaponsSoFar: &weaponsN)
           - draw another 3?
           - manage results
      
      - SimulateTurnThrow(playerPlaying: ZombieDicePlayer, diceToThrow: [ZombieDie], numberOfWeaponsSoFar: inout Int) -> Int
           - throw result
           - rolled 3 💥 so far? -> player's turn is over with 0 gained points
           - manage throw result
              - 🧠 -> +1 point at the end of the turn for current player
              - 👣 -> ask for rerolling that Zombie Die

      - Run() - runs the game 
           - while (there is no winner) {give next player in "players" a turn}
           - a winner? -> ask for new game with same parameters or shut the game down

7) ZombieDice (main) - initializes the Game Core and runs the game
