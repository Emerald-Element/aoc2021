#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_03_test_input.txt"
input_fn := "aoc2021_03_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

ZeroCountList := [0,0,0,0,0]
OneCountList := [0,0,0,0,0]

Loop, Parse, file, `n
	width := StrLen(A_LoopField)

Loop % width {
	ZeroCountList[A_Index] := 0
	OneCountList[A_Index] := 0
}

Loop, Parse, file, `n
{
	;MsgBox % A_LoopField
	line := A_LoopField
	Loop, Parse, line
	{
		if(A_LoopField == "0")
			ZeroCountList[A_Index]++
		if(A_LoopField == "1")
			OneCountList[A_Index]++
	}
}
Loop % width {
	if(ZeroCountList[A_Index] > OneCountList[A_Index]) {
		gamma .= "0"
		epsilon .= "1"
	}
	else {
		gamma .= "1"
		epsilon .= "0"
	}
}
Loop % width {
	i := width + 1 - A_Index
	po2 := Pow(2, A_Index - 1)
	gamma_dec += SubStr(gamma, i, 1) * po2
	epsilon_dec += SubStr(epsilon, i, 1) * po2
}
mult := gamma_dec * epsilon_dec
MsgBox % gamma "`n" epsilon "`n`n" gamma_dec "`n" epsilon_dec "`n`n" mult

ExitApp

Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}