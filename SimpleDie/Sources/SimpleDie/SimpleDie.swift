public class SimpleDie<SideType> 
{
    public let numberOfSides : Int
    var sides:[SideType?]
    public init(numberOfSides: Int, dieSidesList: [SideType])
    {
        self.numberOfSides = numberOfSides
        //sides = [SideType?](repeating: nil, count: numberOfSides)
        sides = dieSidesList
    } 
    public func roll() -> SideType??
    {
        
        return sides.randomElement()
    }
}