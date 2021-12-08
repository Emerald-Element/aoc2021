#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_06_test_input.txt"
input_fn := "aoc2021_06_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

Loop, 256 {
	old_fish =
	new_fish =
	Loop, Parse, file, `,
	{
		;MsgBox % A_LoopField
		if(A_LoopField > 0) {
			old_fish .= "" (StrLen(old_fish) ? "," : "") (A_LoopField - 1)
		}
		else {
			old_fish .= (StrLen(old_fish) ? "," : "") "6"
			new_fish .= (StrLen(new_fish) ? "," : "") "8"
		}
	}
	file := old_fish (StrLen(new_fish) ? "," : "") new_fish
	;MsgBox, DAY %A_Index%`n%file%
	ToolTip % A_Index
}
fish_count := StrLen(RegExReplace(file, ","))
MsgBox % fish_count "`n`n" file

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