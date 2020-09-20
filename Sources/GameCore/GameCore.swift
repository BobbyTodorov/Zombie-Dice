import ZombieDicePlayer
import ZombieDie
import Board

final public class GameCore
{
    var board:Board
    public var players:[ZombieDicePlayer] = Array<ZombieDicePlayer>() //public for tests

    public init()
    {
        board = Board() 
        InitializePlayers()
    }

    public func SimulateTurn(playerPlaying: ZombieDicePlayer)
    {
        var threwBrains:Int = 0
        var threwGuns:Int = 0
        var drawnZDice = playerPlaying.Draw(numberOfDice: 3, fromSetOfDice: &board.zombieDice)
        print("\nPlayer \(playerPlaying.name) has drawn: ")
        for zd in drawnZDice
        {
            zd.printZDie()
        }
        
        let throwResult = playerPlaying.ThrowAllDice()
        print("\n ...and threw: \(throwResult[0])-\(throwResult[1])-\(throwResult[2])")

        var thrownDieIndex:Int = -1
        for zd in throwResult
        {
            thrownDieIndex += 1
            if zd == "🧠"
            {
                threwBrains += 1
            }
            else if zd == "💥"
            {
                threwGuns += 1
                if threwGuns >= 3 
                { 
                    board.Reset()
                    return 
                }
            }
            else //its 👣
            {
                var answer:String = ""
                var newThrow = "👣"
                while (answer != "N" && answer != "n" && newThrow == "👣")
                {
                    print("\(playerPlaying.name), do you want to reroll die №\(thrownDieIndex + 1) as the result was 👣?")
                    repeat
                    {
                        print("Please answer Y/N.")
                        answer = readLine()!
                    } while (answer != "y" && answer != "Y" && answer != "n" && answer != "N")
                    if answer == "n" || answer == "N" { break }

                    newThrow = playerPlaying.ThrowADie(dieToThrow: drawnZDice[thrownDieIndex])
                    switch newThrow
                    {
                        case "🧠":
                            print("Congratz, you got a 🧠 from that die!")
                            threwBrains += 1
                        case "💥":
                            print("Oops, you got a 💥 from that die!")
                            threwGuns += 1
                            if threwGuns >= 3 
                            { 
                                board.Reset()
                                return 
                            }
                        default: print("Ah, you got a 👣 again.")
                    }
                }
            }
        }
        playerPlaying.IncreaseScore(by: threwBrains)
    }

    func PrintPlayersScore()
    {
        print("\nPLAYERS SCORE:")
        for p in players
        {
            print("Player \(p.name) has \(p.GetScore()) score.\n")
        }
    }

    func InitializePlayers()
    {
        var numberOfPlayers:Int
        repeat
        {
            print("Please enter number of players (2~8): ")
            numberOfPlayers = Int(readLine()!)!
        }
        while (numberOfPlayers < 2 || numberOfPlayers > 8)

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