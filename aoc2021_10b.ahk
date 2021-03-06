#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_10_test_input.txt"
input_fn := "aoc2021_10_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

ClosingBracket := {"(":")","[":"]","{":"}","<":">"}
PointValue := {")":1,"]":2,"}":3,">":4}

incomplete_string_count := 0
completion_string_score_list =
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
			corrupt := false
			if(new_bracket == ")" and old_bracket != "(") {
				corrupt := true
				break
			}
			if(new_bracket == "]" and old_bracket != "[") {
				corrupt := true
				break
			}
			if(new_bracket == "}" and old_bracket != "{") {
				corrupt := true
				break
			}
			if(new_bracket == ">" and old_bracket != "<") {
				corrupt := true
				break
			}
		}
	}
	if(corrupt)
		continue
	incomplete_string_count++
	completion_string =
	for k,v in BracketStack
		completion_string := ClosingBracket[v] completion_string
	completion_string_score := 0
	Loop, Parse, completion_string
		completion_string_score := (completion_string_score * 5) + PointValue[A_LoopField]
	completion_string_score_list .= (StrLen(completion_string_score_list) ? "`n" : "") completion_string_score
}
Sort, completion_string_score_list, N
middle_slot := (incomplete_string_count + 1) / 2
Loop, Parse, completion_string_score_list, `n
{
	if(A_Index == middle_slot) {
		middle_completion_string_score := A_LoopField
		break
	}
}
MsgBox, middle_completion_string_score: %middle_completion_string_score%

ExitApp
