#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_03_test_input.txt"
input_fn := "aoc2021_03_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

Loop, Parse, file, `n
	width := StrLen(A_LoopField)

Readings := []
Loop, Parse, file, `n
{
	Readings[A_Index] := A_LoopField
}
Oxygen := []
CO2 := []
for k,v in Readings {
	Oxygen[k] := v
	CO2[k] := v
}

;for k,v in Oxygen
;	out .= k ": " v "`n"
;MsgBox % out
;for k,v in CO2
;	out .= k ": " v "`n"
;MsgBox % out

Loop % width {
	pos := A_Index
	oxy_count_ones := 0
	for k,v in Oxygen
		oxy_count_ones += SubStr(v, pos, 1)
	co2_count_ones := 0
	for k,v in CO2
		co2_count_ones += SubStr(v, pos, 1)
	;MsgBox % Readings.Count() "`n" oxy_count_ones
	oxy_rem := []
	if(oxy_count_ones >= Oxygen.Count() / 2) {
		;MsgBox, IF GREATER THAN TRUE
		for k,v in Oxygen
			if(SubStr(v, pos, 1) == "0")
				oxy_rem.Push(k)
	}
	else {
		;MsgBox, IF GREATER THAN FALSE
		for k,v in Oxygen
			if(SubStr(v, pos, 1) == "1")
				oxy_rem.Push(k)
	}
	co2_rem := []
	if(co2_count_ones < CO2.Count() / 2) {
		;MsgBox, IF GREATER THAN TRUE
		for k,v in CO2
			if(SubStr(v, pos, 1) == "0")
				co2_rem.Push(k)
	}
	else {
		;MsgBox, IF GREATER THAN FALSE
		for k,v in CO2
			if(SubStr(v, pos, 1) == "1")
				co2_rem.Push(k)
	}
	;for k,v in oxy_rem
	;	out2 .= k ": " v "`n"
	;MsgBox % out2
	while(oxy_rem.Count() and Oxygen.Count() > 1) {
		;MsgBox % oxy_rem.Count()
		Oxygen.Remove(oxy_rem.Pop())
	}
	while(co2_rem.Count() and CO2.Count() > 1) {
		;MsgBox % oxy_rem.Count()
		CO2.Remove(co2_rem.Pop())
	}
	;for k,v in Oxygen
	;	out .= k ": " v "`n"
	;MsgBox % out
	;for k,v in CO2
	;	out .= k ": " v "`n"
	;MsgBox % out
}


/*
ZeroCountList := []
OneCountList := []

Loop, Parse, file, `n
	width := StrLen(A_LoopField)

Loop % width {
	ZeroCountList[A_Index] := 0
	OneCountList[A_Index] := 0
}

Readings := []
Loop, Parse, file, `n
{
	Readings[A_Index] := A_LoopField
}
Oxygen := []
Oxygen.clone(Readings)
CO2 := []
CO2.clone(Readings)

Loop % width {
	pos := A_Index
	OxyZeroCountList := []
	OxyOneCountList := []
	Loop % width {
		OxyZeroCountList[A_Index] := 0
		OxyOneCountList[A_Index] := 0
	}
	for k,v in Oxyegn {
		Loop, Parse, v
		{
			if(A_Index < pos)
				continue
			if(A_LoopField == "0")
				OxyZeroCountList[A_Index]++
			if(A_LoopField == "1")
				OxyneCountList[A_Index]++
			if(A_Index > pos)
				break
		}
	}
	CO2ZeroCountList := []
	CO2OneCountList := []
	Loop % width {
		CO2ZeroCountList[A_Index] := 0
		CO2OneCountList[A_Index] := 0
	}
	for k,v in CO2 {
		Loop, Parse, v
		{
			if(A_Index < pos)
				continue
			if(A_LoopField == "0")
				CO2ZeroCountList[A_Index]++
			if(A_LoopField == "1")
				CO2OneCountList[A_Index]++
			if(A_Index > pos)
				break
		}
	}
	Loop % width {
		if(A_Index < pos)
			continue
		oxygen_count := 0
		if(Oxygen.Count() > 1) {
			if(OxyOneCountList[A_Index] < OxyZeroCountList[A_Index]) {
				for k,v in Oxygen {
					if(SubStr(v, pos, 1) == 0)
						Oxygen.Remove(k)
				}
			}
			else {
				for k,v in Oxygen {
					if(SubStr(v, pos, 1) == 1)
						Oxygen.Remove(k)
				}
			}
		}
		if(CO2.Count() > 1) {
			if(CO2OneCountList[A_Index] > CO2ZeroCountList[A_Index]) {
				for k,v in CO2 {
					if(SubStr(v, pos, 1) == 1)
						CO2.Remove(k)
				}
			}
			else {
				for k,v in CO2 {
					if(SubStr(v, pos, 1) == 0)
						CO2.Remove(k)
				}
			}
		}
		if(A_Index > pos)
			break
	}
	if(Oxygen.Count() == 1 and CO2.Count() == 1)
		break
}
*/

oxygen_reading := Oxygen[1]
co2_reading := CO2[1]

Loop % width {
	i := width + 1 - A_Index
	po2 := Pow(2, A_Index - 1)
	oxygen_dec += SubStr(oxygen_reading, i, 1) * po2
	co2_dec += SubStr(co2_reading, i, 1) * po2
}
mult := oxygen_dec * co2_dec
MsgBox % Oxygen.Count() "`n" CO2.Count() "`n`n" oxygen_reading "`n" co2_reading "`n`n" oxygen_dec "`n" co2_dec "`n`n" mult

ExitApp

Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}