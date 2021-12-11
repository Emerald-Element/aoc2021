#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_11_test_input.txt"
input_fn := "aoc2021_11_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

OctopusGrid := []
y := 0
Loop, Parse, file, `n
{
	line := A_LoopField
	y++
	x := 0
	Loop, Parse, line
	{
		x++
		octopus := A_LoopField
		OctopusGrid[x,y] := octopus
	}
}

PermuteGrid(999999)
ShowGrid("permute_count: " permute_count "`n")

ExitApp

PermuteGrid(x) {
	global
	Loop % x {
		permute_count := A_Index
		current_flash_count := 0
		Loop, {
			main_index := A_Index
			energy_gain := (A_Index == 1)
			flash_burnout := !energy_gain
			Loop, 10 {
				y := A_Index
				Loop, 10 {
					x := A_Index
					if(energy_gain)
						OctopusGrid[x,y]++
					else 
					if(OctopusGrid[x,y] > 9) {
						OctopusGrid[x,y] := 0
						total_flash_count++
						current_flash_count++
						flash_y := y - 1
						Loop, 3 {
							flash_x := x - 1
							Loop, 3 {
								if(flash_x >= 1 and flash_x <= 10 and flash_y >= 1 and flash_y <= 10 and OctopusGrid[flash_x,flash_y] != 0) {
									OctopusGrid[flash_x,flash_y]++
									flash_burnout := false
								}
								flash_x++
							}
							flash_y++
						}
					}
				}
			}
			if(flash_burnout)
				break
		}
		if(current_flash_count == 100)
			break
	}
}

ShowGrid(msg:="") {
	global
	out =
	Loop, 10 {
		y := A_Index
		Loop, 10 {
			x := A_Index
			out .= Pad(OctopusGrid[x,y],1)
		}
		out .= "`n"
	}
	MsgBox % msg "`n" out
	return out
}

Pad(raw, width, padding:="0") {
	padded := raw
	while(StrLen(padded) < width)
		padded := padding padded
	return padded
}

CountChar(string, char) {
	return StrLen(RegExReplace(string, "[^" char "]"))
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

Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}