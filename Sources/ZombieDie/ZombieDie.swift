import SimpleDie

open class ZombieDie<String> : SimpleDie<String>
{
    let color:String
    public init(dieSidesList: [String], color: String)
    {
        super.init(dieSidesList: dieSidesList)
        self.color = color
    }
    //public func roll() -> ()
}