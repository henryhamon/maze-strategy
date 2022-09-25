Class tests.dc.maze.unittests.TestSolution Extends %UnitTest.TestCase
{

Method Test42()
{
	Set tExpected=42
  set tResults =42
	Do $$$AssertEquals(tResults,tExpected,tExpected_" = "_tResults)
}

}
