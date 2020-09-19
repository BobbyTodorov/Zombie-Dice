import Player
import Board
import ZombieDie

public class ZombieDicePlayer : Player
{
    var playerDice:[ZombieDie]
    public override init(playerName: String)
    {
        playerDice = Array(repeating: ZombieDie(dieSidesList: [""], color: ""), count: 3)
        super.init(playerName: playerName)
    }
    public func Draw(numberOfDice: Int, fromSetOfDice: inout [ZombieDie]) -> [ZombieDie]
    {
        assert(numberOfDice <= 0 || numberOfDice > 3, "Player \(name) is attempting to draw an invalid number of dice.")

        fromSetOfDice.shuffle()
        for zd in 0...2
        {
            playerDice[zd] = fromSetOfDice[zd]
        }
        return playerDice
    }
    public func ThrowADie(dieToThrow: ZombieDie) -> String
    {
        assert(playerDice[0].sides != [""], "Player \(name) is attempting to throw a die, but he/she hasn't drawn any.")
        
        return dieToThrow.roll()!
    }
    public func ThrowAllDice() -> [String]
    {
        var result:[String] = Array()
        for zd in playerDice
        {
            result.append(ThrowADie(dieToThrow: zd))
        }
        return result
    }
}