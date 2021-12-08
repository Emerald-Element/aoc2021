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
	x1 := m1
	y1 := m2
	x2 := m3
	y2 := m4
	prev_max := max
	max := Max(max, m1 + 1, m2 + 1, m3 + 1, m4 + 1)
	if(max > prev_max)
		Loop % max {
			y := A_Index - 1
			Loop % max {
				x := A_Index - 1
				if(!StrLen(Grid[x,y]))
					Grid[x,y] := "0"
			}
		}
	if(x1 == x2) {
		x := x1
		y := Min(y1, y2)
		while(y <= Max(y1, y2)) {
			Grid[x,y++] += 1 
		}
	}
	else
	if(y1 == y2) {
		x := Min(x1, x2)
		y := y1
		while(x <= Max(x1, x2)) {
			Grid[x++,y] += 1 
		}
	}
	else
		continue
}

Loop % max {
	y := A_Index - 1
	Loop % max {
		out .= Grid[A_Index - 1,y] " "
		if(Grid[A_Index - 1,y] >= 2)
			overlap_count++
	}
	out .= "`n"
}
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