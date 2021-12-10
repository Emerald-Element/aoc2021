#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_10_test_input.txt"
input_fn := "aoc2021_10_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

PointValue := {")":3,"]":57,"}":1197,">":25137}
total_syntax_error_score := 0
Loop, Parse, file, `n
{
	line := A_LoopField
	BracketStack := []
	Loop, Parse, line
	{
		new_bracket := A_LoopField
		if new_bracket in (,[,{,<
		{
			BracketStack.Push(new_bracket)
			continue
		}
		else {
			old_bracket := BracketStack.Pop()
			if(new_bracket == ")" and old_bracket != "(") {
				total_syntax_error_score += PointValue[new_bracket]
				break
			}
			if(new_bracket == "]" and old_bracket != "[") {
				total_syntax_error_score += PointValue[new_bracket]
				break
			}
			if(new_bracket == "}" and old_bracket != "{") {
				total_syntax_error_score += PointValue[new_bracket]
				break
			}
			if(new_bracket == ">" and old_bracket != "<") {
				total_syntax_error_score += PointValue[new_bracket]
				break
			}
		}
	}
}

MsgBox, total_syntax_error_score: %total_syntax_error_score%

ExitApp
