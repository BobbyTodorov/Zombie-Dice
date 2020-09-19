import SimpleDie

public class ZombieDie : SimpleDie<String>
{
    public let color:String
    public init(dieSidesList: [String], color: String)
    {
        self.color = color
        super.init(dieSidesList: dieSidesList)
    }

    public func printZDie()    //test purposes
    {
        print("sides: \(sides) --- color : \(color)")
    }
}