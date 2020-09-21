import ZombieDie

public class Board
{
    public var zombieDice:[ZombieDie]
    
    public init()
    {
        zombieDice = Array()
        Reset()
    }

    public func Reset()
    {
        zombieDice = Array(repeating: ZombieDie(dieSidesList: [], color: ""), count: 13)
        InitZombieDice()
    }

    private func InitZombieDice()
    {
        for i in 0...5
        {
            zombieDice[i] = ZombieDie(dieSidesList: ["🧠","🧠","🧠","👣","👣","💥"], color: "green")
        }
        for i in 6...9
        {
            zombieDice[i] = ZombieDie(dieSidesList: ["🧠","🧠","👣","👣","💥","💥"], color: "yellow")
        }
        for i in 10...12
        {
            zombieDice[i] = ZombieDie(dieSidesList: ["🧠","👣","👣","💥","💥","💥"], color: "red")
        }
    }
}