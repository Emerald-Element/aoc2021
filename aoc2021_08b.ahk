#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_08_test_input_single.txt"
;input_fn := "aoc2021_08_test_input.txt"
input_fn := "aoc2021_08_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

SevenSegment := {abcefg:0,cf:1,acdeg:2,acdfg:3,bcdf:4,abdfg:5,abdefg:6,acf:7,abcdefg:8,abcdfg:9}

Loop, Parse, file, `n
{
	line := A_LoopField
	Wires := {a:"abcdefg",b:"abcdefg",c:"abcdefg",d:"abcdefg",e:"abcdefg",f:"abcdefg",g:"abcdefg"}
	translated_output_values =
	Loop, Parse, line, |
	{
		if(A_Index == 1) {
			signals := A_LoopField
			Loop, Parse, signals, %A_Space%
			{
				word := A_LoopField
				len := StrLen(word)
				if(len == 2) {
					one := word
					Loop, Parse, word
					{
						if(CountChar(signals, A_LoopField) == 8)
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^c])")
						if(CountChar(signals, A_LoopField) == 9)
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^f])")
					}
					break
				}
			}
			Loop, Parse, signals, %A_Space%
			{
				word := A_LoopField
				len := StrLen(word)
				if(len == 3) {
					Loop, Parse, word
						if one not contains %A_LoopField%
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^a])")
					break
				}
			}
			Loop, Parse, signals, %A_Space%
			{
				word := A_LoopField
				len := StrLen(word)
				if(len == 4) {
					Loop, Parse, word
					{
						if(CountChar(signals, A_LoopField) == 6)
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^b])")
						if(CountChar(signals, A_LoopField) == 7) {
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^d])")
							hide_the_d := A_LoopField
						}
					}
					break
				}
			}
			Loop, Parse, signals, %A_Space%
			{
				word := A_LoopField
				len := StrLen(word)
				if(len == 7) {
					Loop, Parse, word
					{
						if(CountChar(signals, A_LoopField) == 4)
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^e])")
						if(CountChar(signals, A_LoopField) == 7 and A_LoopField != hide_the_d)
							Wires[A_LoopField] := RegExReplace(Wires[A_LoopField], "([^g])")
					}
					break
				}
			}
		} ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Solved jumble
		else {
			output_values := A_LoopField
			Loop, Parse, output_values, %A_Space%
			{
				if(!StrLen(A_LoopField))
					continue
				word := A_LoopField
				translated_word =
				translated_char_list =
				Loop, Parse, word
				{
					translated_char_list .= (StrLen(translated_char_list) ? "`n" : "") Wires[A_LoopField]
				}
				alphabetized_translated_char_list := translated_char_list
				Sort, alphabetized_translated_char_list
				alphabetized_translated_word := RegExReplace(alphabetized_translated_char_list, "`n")
				translated_output_values .= SevenSegment[alphabetized_translated_word]
			}
		}
	}
	sum_output_values += translated_output_values
}
MsgBox, sum_output_values: %sum_output_values%

ExitApp

CountChar(string, char) {
	return StrLen(RegExReplace(string, "[^" char "]"))
}
