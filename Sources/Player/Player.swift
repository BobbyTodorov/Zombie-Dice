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
        if by > 0 { score += by }
    }

    public func ResetScore()
    {
        score = 0
    }
    
    public func GetScore() -> Int
    {
        return score
    }
}