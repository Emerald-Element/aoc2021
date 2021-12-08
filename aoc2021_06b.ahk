#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_06_test_input.txt"
input_fn := "aoc2021_06_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

FishCycle := []
Loop, 9
	FishCycle[A_Index - 1] := 0

;for k,v in FishCycle
;	out .= k ": " v "`n"
;MsgBox % out

Loop, Parse, file, `,
{
	FishCycle[A_LoopField] += 1
}

Loop, 256 {
	zero := FishCycle.RemoveAt(0)
	if(zero) {
		FishCycle[6] := (StrLen(FishCycle[6]) ? FishCycle[6] + zero : zero)
		FishCycle[8] := zero
	}
	;out := "removed: " zero "`n`n"
	;for k,v in FishCycle {
	;	out .= k ": " v "`n"
	;	fish_count += v
	;}
	;MsgBox % "DAY " A_Index "`n" fish_count "`n`n" out
}

fish_count := 0
for k,v in FishCycle {
	out .= k ": " v "`n"
	fish_count += v
}
MsgBox % fish_count "`n`n" out

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