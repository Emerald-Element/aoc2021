#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_08_test_input.txt"
input_fn := "aoc2021_08_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

Loop, Parse, file, `n
{
	line := A_LoopField
	mode := 0
	Loop, Parse, line, %A_Space%
	{
		word := A_LoopField
		if(word == "|") {
			mode := 1
			continue
		}
		if(!mode)
			continue
		len := StrLen(word)
		if len in 2,3,4,7
		{
			;MsgBox % word " " len
			count_unique++
		}
	}
}
MsgBox % count_unique

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