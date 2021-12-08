#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_07_test_input.txt"
input_fn := "aoc2021_07_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

file := RegExReplace(file, ",", "`n")

Sort, file, N

Crabs := []
Loop, Parse, file, `n
{
	Crabs[A_Index] := A_LoopField
}
median :=  Crabs[Floor(Crabs.Count() / 2)]

for k,v in Crabs
	fuel += Abs(v - median)

MsgBox % median "`n" fuel

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