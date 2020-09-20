import SimpleDie

public class ZombieDie : SimpleDie<String>
{
    public let color:String
    public init(dieSidesList: [String], color: String)
    {
        //assert((dieSidesList.count == 6 || dieSidesList.isEmpty) && (color == "green" || color == "red" || color == "yellow" || color == ""), "Invalid Zombie Die!")
        self.color = color
        super.init(dieSidesList: dieSidesList)
    }

    public func printZDie()    //test purposes
    {
        print("sides: \(sides[0])-\(sides[1])-\(sides[2])-\(sides[3])-\(sides[4])-\(sides[5]) --- color : \(color)") //print sides as chars
    }
}