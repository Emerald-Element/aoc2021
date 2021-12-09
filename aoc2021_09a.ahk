#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_09_test_input.txt"
input_fn := "aoc2021_09_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

HeightMap := []
y := 0
Loop, Parse, file, `n
{
	y++
	line := A_LoopField
	x := 0
	Loop, Parse, line
	{
		x++
		HeightMap[x,y] := A_LoopField
	}
}
x_max := x
y_max := y
Loop % y_max {
	y := A_Index
	Loop % x_max {
		x := A_Index
		;MsgBox % x " " y " " HeightMap[x,y]
		height := HeightMap[x,y]
		lowest := true
		if(x > 1 and HeightMap[x-1,y] <= height)
			lowest := false
		if(x < x_max and HeightMap[x+1,y] <= height)
			lowest := false
		if(y > 1 and HeightMap[x,y-1] <= height)
			lowest := false
		if(y < y_max and HeightMap[x,y+1] <= height)
			lowest := false
		if(lowest)
			sum_risk_level += 1 + height
	}
}
MsgBox, sum_risk_level: %sum_risk_level%

ExitApp
