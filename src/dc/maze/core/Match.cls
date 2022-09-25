Class dc.maze.core.Match Extends %Persistent
{

Property Steps As list Of %String;

Property Maze As %String;

Property Score As %Integer [ InitialExpression = 1 ];

Property CreatedAt As %DateTime;

Method %OnNew() As %Status
{
  Set ..CreatedAt = $ZDateTime($NOW(), 3)
  Return $$$OK
}

Storage Default
{
<Data name="MatchDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Steps</Value>
</Value>
<Value name="3">
<Value>Maze</Value>
</Value>
<Value name="4">
<Value>Score</Value>
</Value>
<Value name="5">
<Value>CreatedAt</Value>
</Value>
</Data>
<DataLocation>^dc.maze.core.MatchD</DataLocation>
<DefaultData>MatchDefaultData</DefaultData>
<IdLocation>^dc.maze.core.MatchD</IdLocation>
<IndexLocation>^dc.maze.core.MatchI</IndexLocation>
<StreamLocation>^dc.maze.core.MatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
