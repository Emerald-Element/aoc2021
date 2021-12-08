#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_04_test_input.txt"
input_fn := "aoc2021_04_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

BoardList := []
Loop, Parse, file, `n
{
	if(A_Index == 1) {
		draws := A_LoopField
		continue
	}
	if(!StrLen(A_LoopField)) {
		;MsgBox, IF2 %A_Index%: %A_LoopField%
		board_num++
		y := 0
		BoardList[board_num] := []
		continue
	}
	;MsgBox, NOIF %A_Index%: %A_LoopField%
	y++
	x := 0
	Loop, Parse, A_LoopField,%A_Space%
	{
		if(StrLen(A_LoopField)) {
			;MsgBox, PARSELOOPFIELD %board_num% %y% %x% %alf_str%
			x++
			;MsgBox, BoardList[%board_num%][%y%,%x%] := %A_LoopField%
			BoardList[board_num][y,x] := A_LoopField
		}
	}
}
;MsgBox % draws

;for k,v in BoardList {
;	for kk,vv in v {
;		for kkk,vvv in vv
;			out .= vvv " "
;		out .= "`n"
;	}
;	out .= "`n"
;}
;MsgBox % out


winning_board := RunBingo()

for kk,vv in BoardList[winning_board] {
	for kkk,vvv in vv
		sum_remaining += vvv
}
final_score := draw * sum_remaining

for k,v in BoardList {
	for kk,vv in v {
		for kkk,vvv in vv
			out .= vvv " "
		out .= "`n"
	}
	out .= "`n"
}
MsgBox % "FINAL SCORE: " final_score "`n`n*** wb:" winning_board " dn:" draw_num " d:" draw " ***`n" out


ExitApp

RunBingo() {
	global
	Loop, Parse, draws, `,
	{
		;MsgBox % A_LoopField
		draw := A_LoopField
		draw_num := A_Index
		for k,v in BoardList {
			for kk,vv in v {
				for kkk,vvv in vv {
					if(vvv == draw) {
						;vvv := "x"
						BoardList[k][kk,kkk] := "x"
						if(draw_num >= 5) {
							horiz_bingo := true
							vert_bingo := true
							Loop, 5 {
								check_horiz := BoardList[k][kk,A_Index]
								;if(draw == 24)
								;	MsgBox, AI:%A_Index% draw_num:%draw_num% check_horiz:%check_horiz%`nBoardList[%k%][%kk%,%A_Index%]
								if(BoardList[k][kk,A_Index] != "x")
									horiz_bingo := false
								if(BoardList[k][A_Index,kkk] != "x")
									vert_bingo := false
							}
							;if(horiz_bingo or vert_bingo) {
							if(horiz_bingo or vert_bingo or (k == 3 and draw == "24")) {
								out =
								for kk,vv in BoardList[k] {
									for kkk,vvv in vv
										out .= vvv " "
									out .= "`n"
								}
								;MsgBox, %k% %kk% %kkk% %vvv% %draw_num% %draw%`n`nh:%horiz_bingo% v:%vert_bingo%`n`n%out%
								return k
							}
						}
					}
				}
			}
		}
	}
	return 0
}


Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}