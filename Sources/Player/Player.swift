open class Player
{
    public var name:String
    var score:Int
    public init(playerName: String)
    {
        name = playerName
        score = 0
    }
    public func IncreaseScore(by: Int) 
    {
        score += by
    }
    public func GetScore() -> Int
    {
        return score
    }
}