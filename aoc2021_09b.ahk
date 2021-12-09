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

basin_list =
Loop % y_max {
	y := A_Index
	Loop % x_max {
		x := A_Index
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
		if(lowest) {
			BasinMap := []
			RecurseBasin(x, y)
			out =
			basin_size := 0
			Loop % y_max {
				yy := A_Index
				Loop % x_max {
					xx := A_Index
					if(BasinMap[xx,yy]) {
						basin_size++
					}
				}
			}
			basin_list .= (StrLen(basin_list) ? "`n" : "") basin_size
		}
	}
}
Sort, basin_list, NR
triple_basin := 1
Loop, Parse, basin_list, `n
{
	triple_basin *= A_LoopField
	if(A_Index == 3)
		break
}
MsgBox, triple_basin: %triple_basin%

ExitApp

RecurseBasin(x, y) {
	global
	height := HeightMap[x,y]
	BasinMap[x,y] := 1
	if(!BasinMap[x-1,y] and x > 1 and HeightMap[x-1,y] != 9) {
		BasinMap[x-1,y] := 1
		RecurseBasin(x-1,y)
	}
	if(!BasinMap[x+1,y] and x < x_max and HeightMap[x+1,y] != 9) {
		BasinMap[x+1,y] := 1
		RecurseBasin(x+1,y)
	}
	if(!BasinMap[x,y-1] and y > 1 and HeightMap[x,y-1] != 9) {
		BasinMap[x,y-1] := 1
		RecurseBasin(x,y-1)
	}
	if(!BasinMap[x,y+1] and y < y_max and HeightMap[x,y+1] != 9) {
		BasinMap[x,y+1] := 1
		RecurseBasin(x,y+1)
	}
}
