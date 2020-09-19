//testing here
import Board
import ZombieDicePlayer

let board = Board()
for i in board.zombieDice {
    i.printZDie()
}
print("\n")

var zdp:ZombieDicePlayer = ZombieDicePlayer(playerName: "Bobi")
print(zdp.ThrowAllDice())


