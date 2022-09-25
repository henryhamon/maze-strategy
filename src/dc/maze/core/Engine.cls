Class dc.maze.core.Engine Extends %RegisteredObject
{

Parameter CELL = 0;

Parameter WALL = 1;

Parameter END = "E";

Property Steps As list Of %String;

Property MazeX As %Integer [ InitialExpression = 1 ];

Property MazeY As %Integer [ InitialExpression = 1 ];

Property Score As %Integer [ InitialExpression = 1 ];

Property Top As %Integer;

Property Right As %Integer;

Property Bottom As %Integer;

Property Left As %Integer;

Property IsWin As %Boolean [ InitialExpression = 0 ];

Method Preparation() As %Status
{
  Set tSC = $$$OK
	Try {
    Set ..Score = $Get(^Map("Score"))
    Do ..Steps.Clear()
    Set ..MazeX = $Get(^Map("StartX"))
    Set ..MazeY = $Get(^Map("StartY"))
    $$$TOE(tSC, ..GetSides())
    Set ..IsWin = $$$NO

	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method MoveUp()
{
  Set move = "Up"
  Set mazeY = ..MazeY - 1
  Do ..Move(move, ..MazeX, mazeY)
}

Method MoveDown()
{
  Set move = "Down"
  Set mazeY = ..MazeY + 1
  Do ..Move(move, ..MazeX, mazeY)
}

Method MoveLeft()
{
  Set move = "Left"
  Set mazeX = ..MazeX - 1
  Do ..Move(move, mazeX, ..MazeY)
}

Method MoveRight()
{
  Set move = "Right"
  Set mazeX = ..MazeX + 1
  Do ..Move(move, mazeX, ..MazeY)
}

Method Move(Move As %String, MazeX As %Integer, MazeY As %Integer) As %Status [ Private ]
{
  Set tSC = $$$OK
	Try {
    Do ..CheckIsAllowed(MazeX, MazeY, .allowed)
    Set:('allowed) Move = Move _ " Not Allowed"
    Do ..Steps.Insert(Move)
    Set ..Score = ..Score - 1
    If (allowed) {
      Set ..MazeX = MazeX
      Set ..MazeY = MazeY
      Set:(..CheckIsWin(MazeX, MazeY)) ..IsWin = $$$YES
    }
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method CheckIsWin(MazeX As %Integer, MazeY As %Integer) As %Boolean
{
  Set win = $$$NO
  If ($Piece(^Map(MazeY),"^", MazeX) = ..#END) {
    Set win = $$$YES
  }
  Quit win
}

Method GetSides() As %Status
{
  Set tSC = $$$OK
	Try {
    Set ..Top = $Replace($Piece($Get(^Map(..MazeY - 1)),"^", ..MazeX), ..#END, ..#CELL)
    Set ..Right = $Replace($Piece($Get(^Map(..MazeY)),"^", ..MazeX + 1), ..#END, ..#CELL)
    Set ..Bottom = $Replace($Piece($Get(^Map(..MazeY + 1)),"^", ..MazeX), ..#END, ..#CELL)
    Set ..Left = $Replace($Piece($Get(^Map(..MazeY)),"^", ..MazeX - 1), ..#END, ..#CELL)

	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method CheckIsAllowed(MazeX As %Integer, MazeY As %Integer, Output Allowed As %Boolean) As %Status
{
  Set tSC = $$$OK
  Set Allowed = $$$NO
	Try {
    Return:($Piece($Get(^Map(MazeY)),"^", MazeX)="") tSC
    Return:($Piece($Get(^Map(MazeY)),"^", MazeX)= ..#WALL) tSC
    Set Allowed = $$$YES
	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

Method HasNextTurn() As %Boolean
{
  Quit:(..IsWin) $$$NO
  Quit:(..Score < 1) $$$NO
  Quit $$$YES
}

Method EndMatch(maze as %String) As %Status
{
  Set tSC = $$$OK
	Try {
    Set match = ##class(dc.maze.core.Match).%New()
    Set match.Score = ..Score
    Set match.Maze = maze
    For ix=1:1:..Steps.Count() {
      Do match.Steps.Insert(..Steps.GetAt(ix))
    }
    $$$TOE(tSC, match.%Save())

	} Catch tException {
		Set:$$$ISOK(tSC) tSC = tException.AsStatus()
	}
	Quit tSC
}

ClassMethod LoadEasyMaze() As %Status
{
  Kill ^Map
  Set ^Map("Score") = 150
  Set ^Map("StartX") = 1
  Set ^Map("StartY")  = 1
  Set ^Map(1 ) = "0^0^1^0^0^0^0^1^0^0"
  Set ^Map(2 ) = "0^1^0^0^0^0^0^0^0^0"
  Set ^Map(3 ) = "0^0^0^0^0^0^1^0^0^0"
  Set ^Map(4 ) = "0^0^0^1^0^0^0^0^0^0"
  Set ^Map(5 ) = "0^1^0^0^0^1^1^0^1^0"
  Set ^Map(6 ) = "0^0^1^0^0^0^1^0^0^0"
  Set ^Map(7 ) = "0^0^0^0^0^0^0^1^0^1"
  Set ^Map(8 ) = "0^0^1^0^0^0^0^0^1^0"
  Set ^Map(9 ) = "0^0^0^0^1^0^1^0^0^0"
  Set ^Map(10) = "0^0^1^0^1^0^0^1^1^E"
}

/// 45x20 Maze
ClassMethod LoadHardMaze()
{
  Kill ^Map
  Set ^Map("Score") = 600
  Set ^Map("StartX") = 4
  Set ^Map("StartY")  = 4
  Set ^Map( 1) = "1^1^0^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1"
  Set ^Map( 2) = "1^1^0^1^1^0^0^0^1^0^0^0^1^1^0^1^0^1^0^1"
  Set ^Map( 3) = "1^0^0^0^1^1^0^1^1^0^1^1^1^1^0^1^0^0^0^1"
  Set ^Map( 4) = "1^1^1^0^0^0^0^0^0^0^0^0^0^0^0^0^0^1^0^1"
  Set ^Map( 5) = "1^0^0^0^1^1^0^1^0^1^0^1^1^1^1^1^1^1^0^1"
  Set ^Map( 6) = "1^1^1^0^1^1^1^1^1^1^1^1^1^1^0^1^0^0^0^1"
  Set ^Map( 7) = "1^1^1^0^0^0^0^0^0^0^1^1^0^1^0^1^0^1^1^1"
  Set ^Map( 8) = "1^0^1^0^1^1^1^1^1^1^1^0^0^0^0^0^0^0^1^1"
  Set ^Map( 9) = "1^0^1^0^0^0^1^1^1^0^1^1^0^1^1^1^1^0^0^1"
  Set ^Map(10) = "1^0^0^0^1^1^1^0^1^0^1^1^0^1^1^0^0^1^0^1"
  Set ^Map(11) = "1^1^1^0^1^1^1^0^1^0^1^0^0^0^1^0^1^1^0^1"
  Set ^Map(12) = "1^0^1^0^0^0^1^0^1^0^0^0^1^0^1^0^1^1^0^1"
  Set ^Map(13) = "1^0^1^0^1^1^1^0^1^0^1^0^1^1^0^0^1^0^0^1"
  Set ^Map(14) = "1^0^1^0^1^1^0^0^1^1^1^0^0^1^1^0^1^0^1^1"
  Set ^Map(15) = "1^0^0^0^0^1^1^0^0^0^1^1^0^1^1^0^1^0^1^1"
  Set ^Map(16) = "1^0^1^1^0^0^1^1^0^1^1^1^0^0^1^0^1^0^0^1"
  Set ^Map(17) = "1^1^1^1^1^0^1^1^0^1^0^1^1^0^0^0^0^0^1^1"
  Set ^Map(18) = "1^0^0^0^1^0^1^1^0^0^0^1^1^0^1^1^1^1^1^1"
  Set ^Map(19) = "1^1^1^0^0^0^1^1^0^1^1^1^1^0^1^0^0^0^0^1"
  Set ^Map(20) = "1^0^1^0^1^0^0^0^0^0^1^0^1^0^1^0^1^1^0^1"
  Set ^Map(21) = "1^0^0^1^1^1^0^1^1^1^1^0^1^0^0^0^0^1^0^1"
  Set ^Map(22) = "1^0^1^1^0^0^0^0^0^1^1^0^1^0^1^1^1^1^0^1"
  Set ^Map(23) = "1^0^0^1^1^1^1^0^1^1^0^0^0^0^0^0^0^0^0^1"
  Set ^Map(24) = "1^0^1^1^0^0^0^0^1^1^1^0^1^0^1^1^0^1^1^1"
  Set ^Map(25) = "1^0^1^1^1^1^1^0^0^0^0^1^1^0^1^1^1^0^0^1"
  Set ^Map(26) = "1^0^0^1^1^1^0^0^1^1^1^1^0^0^0^0^1^1^0^1"
  Set ^Map(27) = "1^0^1^1^0^1^1^0^0^1^1^0^0^1^0^1^1^1^0^1"
  Set ^Map(28) = "1^0^1^1^0^1^0^0^1^1^1^0^1^1^1^0^0^0^0^1"
  Set ^Map(29) = "1^0^0^1^0^1^0^1^1^1^0^0^1^0^1^1^1^1^0^1"
  Set ^Map(30) = "1^1^0^1^0^1^0^0^0^1^1^0^0^0^0^1^0^1^0^1"
  Set ^Map(31) = "1^0^0^0^0^0^0^1^1^1^1^0^1^0^1^1^0^1^0^1"
  Set ^Map(32) = "1^1^1^1^1^1^0^1^0^1^0^0^1^1^0^0^0^0^0^1"
  Set ^Map(33) = "1^1^0^0^1^1^0^1^0^0^0^1^1^1^1^1^0^1^1^1"
  Set ^Map(34) = "1^0^0^1^1^0^0^0^0^1^1^1^0^1^1^0^0^1^1^1"
  Set ^Map(35) = "1^1^0^0^1^1^0^1^1^1^1^1^0^0^1^1^0^1^0^1"
  Set ^Map(36) = "1^0^0^1^1^0^0^0^0^0^0^1^1^0^1^1^0^0^0^1"
  Set ^Map(37) = "1^1^0^1^1^1^0^1^1^1^1^1^0^0^0^0^0^1^1^1"
  Set ^Map(38) = "1^0^0^1^0^1^0^0^1^1^0^0^0^1^1^1^0^0^0^1"
  Set ^Map(39) = "1^1^0^1^0^1^0^1^1^1^0^1^1^1^0^1^1^1^0^1"
  Set ^Map(40) = "1^0^0^1^0^0^0^0^0^0^0^1^0^0^0^0^1^0^0^1"
  Set ^Map(41) = "1^1^0^1^0^1^1^0^1^1^1^1^0^1^1^0^0^0^1^1"
  Set ^Map(42) = "1^1^0^1^0^1^1^0^0^0^0^0^0^0^0^1^1^0^0^1"
  Set ^Map(43) = "1^0^0^0^0^1^0^1^1^1^0^1^0^1^0^0^0^1^1^1"
  Set ^Map(44) = "1^1^0^1^0^0^0^0^0^0^0^0^1^1^1^1^0^0^E^1"
  Set ^Map(45) = "1^1^1^1^1^1^0^1^1^1^0^1^1^1^1^1^1^1^1^1"
}

}
