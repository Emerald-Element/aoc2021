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
;median :=  Crabs[Floor(Crabs.Count() / 2)]

for k,v in Crabs
	sum += v
avg := Round(sum / Crabs.Count())
;MsgBox % avg

check_num := avg - 10
Loop, 20 {
	fuel := 0
	for k,v in Crabs {
		Loop % Abs(v - check_num)
			fuel += A_Index
		;MsgBox, %avg%`n%k%: %v%`n%fuel%
	}
	if(A_Index == 1) {
		fuel_min := fuel
		num_min := check_num
	}
	else {
		if(fuel < fuel_min) {
			fuel_min := fuel
			num_min := check_num
		}
	}
	check_num++
}
MsgBox % num_min "`n" fuel_min

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