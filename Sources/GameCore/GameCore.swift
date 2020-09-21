import ZombieDicePlayer
import ZombieDie
import Board

final public class GameCore
{
    var board:Board
    var players:[ZombieDicePlayer] = Array<ZombieDicePlayer>()

    public init()
    {
        board = Board()
    }

    public func Run()
    {
        print("GAME ON!")
        InitializePlayers()

        var playerIter:Int = 0
        while true //the game
        {
            repeat
            {
                print("\nAre you ready, \(players[playerIter].name)?")
            } while !GetAnswerYN()

            SimulateTurn(playerPlaying: players[playerIter])
            if players[playerIter].GetScore() >= 13 
            {
                print("\n***WINNER IS \(players[playerIter].name)!***")
                print("\nDo you guys want to play a new game?")
                if !GetAnswerYN() { break }
                else 
                { 
                    ResetPlayersScore() 
                    playerIter = players.count //eqv to reset
                }
            }
            PrintPlayersScore()
            board.Reset()
            playerIter = (playerIter+1) % players.count
        }
        print("\nSHUTTING DOWN") 

    }

    func SimulateTurn(playerPlaying: ZombieDicePlayer) //main Turn/Game/ logic
    {
        print("""
            
            ================================
            Now playing \(playerPlaying.name).
            ================================
            """)
        var drawnZDice = playerPlaying.Draw(numberOfDice: 3, fromSetOfDice: &board.zombieDice)
        print("\nDrawn dice: ")
        for zd in drawnZDice
        {
            zd.printZDie()
        }

        var weaponsN:Int = 0
        var brainsN:Int = 0
        var throwResult = SimulateTurnThrow(playerPlaying: playerPlaying, diceToThrow: drawnZDice, numberOfWeaponsSoFar: &weaponsN)
        if throwResult == -1
        { 
            print("\(playerPlaying.name), you got 3x 💥! Your turn ends here with 0 gained score.")
            return
        } 
        else { brainsN += throwResult }
    
        print("""
            ================================
            \(playerPlaying.name), would you like to throw three new dice?
            """)

        if GetAnswerYN() 
        {
            drawnZDice = playerPlaying.Draw(numberOfDice: 3, fromSetOfDice: &board.zombieDice)
            print("\nSecond attempt... \nDrawn dice: ")
            for zd in drawnZDice { zd.printZDie() }
            throwResult = SimulateTurnThrow(playerPlaying: playerPlaying, diceToThrow: drawnZDice, numberOfWeaponsSoFar: &weaponsN)
            if throwResult == -1
            { 
                print("\(playerPlaying.name), you got 3x💥 in total! Your turn ends here with 0 gained score.")
                return
            } else
            {
                brainsN += throwResult
            }
        }
        print("\n\(playerPlaying.name)'s turn ends with a total of \(brainsN) gained score!")
        playerPlaying.IncreaseScore(by: brainsN)
    }

    func SimulateTurnThrow(playerPlaying: ZombieDicePlayer, diceToThrow: [ZombieDie], numberOfWeaponsSoFar: inout Int) -> Int
    {
        var threwBrains:Int = 0
        let throwResult = playerPlaying.ThrowAllDice()
        print("\n ...and threw: \(throwResult[0])-\(throwResult[1])-\(throwResult[2])")

        var thrownDieIndex:Int = -1
        for zd in throwResult //just interrupt turn if 3 weapons were thrown
        {
            if zd == "💥"
            {
                numberOfWeaponsSoFar += 1
                if numberOfWeaponsSoFar >= 3 {  return -1 }
            }
        }
        for zd in throwResult
        {
            thrownDieIndex += 1
            if zd == "🧠"
            {
                threwBrains += 1
            }
            else if zd == "👣"
            {
                var answer:Bool = true
                var newThrow = "👣"

                while (answer && newThrow == "👣")
                {
                    print("\(playerPlaying.name), do you want to reroll die №\(thrownDieIndex + 1) as the result was 👣?")
                    answer = GetAnswerYN()
                    if !answer { break }

                    newThrow = playerPlaying.ThrowADie(dieToThrow: diceToThrow[thrownDieIndex])
                    switch newThrow
                    {
                        case "🧠":
                            print("Congratz, you got a 🧠 from that die!")
                            threwBrains += 1
                        case "💥":
                            print("Oops, you got a 💥 from that die!")
                            numberOfWeaponsSoFar += 1
                            if numberOfWeaponsSoFar >= 3 {  return -1 }
                        default: print("Ah, you got a 👣 again.")
                    }
                }
            }
        }
        return threwBrains
    }

    func GetAnswerYN() -> Bool
    {
        var answer:String = ""
        repeat
            {
                print("Please answer Y/N.")
                answer = readLine()!
            } 
        while (answer != "y" && answer != "Y" && answer != "n" && answer != "N")

        if answer == "y" || answer == "Y" {return true}
        return false
    }

    func PrintPlayersScore()
    {
        print("""

        ================================
        PLAYERS SCORE SO FAR:
        """)
        for p in players
        {
            print("\(p.name) --- \(p.GetScore()) score")
        }
    }

    func ResetPlayersScore()
    {
        for p in players
        {
            p.ResetScore()
        }
    }

    func InitializePlayers()
    {
        var inputStr:String
        repeat
        {
            print("Please enter number of players (2~8): ")
            inputStr = readLine()!
        }
        while (inputStr != "2" && inputStr != "3" && inputStr != "4" && inputStr != "5"
                && inputStr != "6" && inputStr != "7" && inputStr != "8")

        let numberOfPlayers:Int = Int(inputStr)!
        for p in 0...numberOfPlayers-1
        {
            var playerNameTmp:String
            var isNameUsed:Bool = false
            repeat
            {
                print("\nPlease enter Player \(p+1)'s unique name: ")
                playerNameTmp = readLine()!
                isNameUsed = false
                for n in players
                {
                    if n.name == playerNameTmp
                    {
                        isNameUsed = true
                    }
                }
            } while (isNameUsed == true)
            let playerTmp = ZombieDicePlayer(playerName: playerNameTmp)
            players.append(playerTmp)
        }
    }
}