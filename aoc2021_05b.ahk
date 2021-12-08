#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_05_test_input.txt"
input_fn := "aoc2021_05_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

Grid := []
Loop, Parse, file, `n
{
	;MsgBox % A_LoopField
	RegExMatch(A_LoopField, "(\d+),(\d+) -> (\d+),(\d+)", m)
	;MsgBox %m1%`n%m2%`n%m3%`n%m4%
	max := Max(max, m1 + 1, m2 + 1, m3 + 1, m4 + 1)
}
MsgBox % max
Loop % max {
	y := A_Index - 1
	Loop % max {
		x := A_Index - 1
		if(!StrLen(Grid[x,y]))
			Grid[x,y] := "0"
	}
}
	
Loop, Parse, file, `n
{
	;MsgBox % A_LoopField
	RegExMatch(A_LoopField, "(\d+),(\d+) -> (\d+),(\d+)", m)
	;MsgBox %m1%`n%m2%`n%m3%`n%m4%
	x1 := m1
	y1 := m2
	x2 := m3
	y2 := m4

	x_dir := (x1 == x2 ? 0 : (x2 > x1 ? 1 : -1))
	y_dir := (y1 == y2 ? 0 : (y2 > y1 ? 1 : -1))
	x := x1
	y := y1
	Loop {
		Grid[x,y] += 1
		x += x_dir
		y += y_dir
		if(x == x2 and y == y2) {
			Grid[x,y] += 1
			break
		}
	}
}

Loop % max {
	y := A_Index - 1
	Loop % max {
		out .= Grid[A_Index - 1,y]
		if(Grid[A_Index - 1,y] >= 2)
			overlap_count++
	}
	out .= "`n"
}
FileDelete, aoc2021_05b_grid.txt
FileAppend, %out%, aoc2021_05b_grid.txt
MsgBox % overlap_count "`n`n" out

ExitApp

Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}

Min(vals*) {
	min := vals[1]
	for k,v in vals
		if(v < min)
			min := v
	return min
}

Max(vals*) {
	max := vals[1]
	for k,v in vals
		if(v > max)
			max := v
	return max
}