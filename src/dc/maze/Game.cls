Class dc.maze.Game Extends %RegisteredObject
{

ClassMethod EasyMatch() As %Status
{
  Quit ..Match("easy")
}

ClassMethod HardMatch() As %Status
{
  Quit ..Match("hard")
}

ClassMethod Match(maze As %String = "easy") As %Status
{
  Set tSC = $$$OK
	Try {
    Return:(maze = "") tSC
    Do:(maze="easy") ##class(dc.maze.core.Engine).LoadEasyMaze()
    Do:(maze="hard") ##class(dc.maze.core.Engine).LoadHardMaze()
    Set game = ##class(dc.maze.core.Engine).%New()
    Set strategy = ##class(dc.maze.Strategy).%New()
    Throw:($$$ISERR(tSC)) tSC

    $$$TOE(tSC, game.Preparation())
    While (game.HasNextTurn()) {
      $$$TOE(tSC, ..Round(.strategy, .game))
    }

    $$$TOE(tSC, game.EndMatch(maze))
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod Round(strategy As dc.maze.Strategy, ByRef game As dc.maze.core.Engine) As %Status
{
  Set tSC = $$$OK
	Try {
      Set solution = ""
      Set solution = $ZConvert(strategy.GetNextTurn(game.Top, game.Bottom, game.Left, game.Right), "l")
      Do:(solution="up") game.MoveUp()
      Do:(solution="right") game.MoveRight()
      Do:(solution="down") game.MoveDown()
      Do:(solution="left") game.MoveLeft()
      // If player method doesn't return anything it will decrese the score
      Set:(solution="") game.Score = game.Score - 1
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

}
