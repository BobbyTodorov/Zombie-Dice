import ZombieDicePlayer
import Board

final public class GameCore
{
    var board:Board
    var players:[ZombieDicePlayer] = Array<ZombieDicePlayer>()

    public init(playersCount: Int)
    {
        board = Board()
        for _ in 0...playersCount-1
        {
            print("\nEnter player name:")
            //TO DO NAME CHECK
            let playerNameTmp = readLine()
            let playerTmp = ZombieDicePlayer(playerName: playerNameTmp!)
            players.append(playerTmp)
        }
    }
    public func PrintPlayersScore()
    {
        print("\nPLAYERS SCORE:")
        for p in players
        {
            print("Player \(p.name) has \(p.GetScore()) score.\n")
        }
    }
}