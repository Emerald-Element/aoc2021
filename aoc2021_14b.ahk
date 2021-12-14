#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_14_test_input.txt"
input_fn := "aoc2021_14_input.txt"

FileRead, file, %input_fn%
;MsgBox % file

file := RegExReplace(file, "`r")

InsertionRules := []
Loop, Parse, file, `n
{
	line := A_LoopField
	if(A_Index == 1)
		polymer_template := line
	if(A_Index >= 3) {
		if(RegExMatch(line, "^(\w{2}) -> (\w)$", m)) {
			InsertionRules[m1] := m2
		}
	}
	irc := InsertionRules.Count()
	ShowOutput()
}

PolymerPairs := []
Loop {
	pair := SubStr(polymer_template, A_Index, 2)
	if(StrLen(pair) == 2) {
		pair_count := PolymerPairs[pair]
		PolymerPairs[pair] := (pair_count ? pair_count + 1 : 1)
	}
	else
		break
}

Loop, 40 {
	PairUpdates := []
	for k,v in PolymerPairs {
		PairUpdates[k] := (StrLen(PairUpdates[k]) ? PairUpdates[k] - v : -v)
		new_element := InsertionRules[k]
		left_pair := SubStr(k,1,1) new_element
		right_pair := new_element SubStr(k,2,1)
		PairUpdates[left_pair] := (StrLen(PairUpdates[left_pair]) ? PairUpdates[left_pair] + v : v)
		PairUpdates[right_pair] := (StrLen(PairUpdates[right_pair]) ? PairUpdates[right_pair] + v : v)
	}
	for k,v in PairUpdates
		PolymerPairs[k] := (StrLen(PolymerPairs[k]) ? PolymerPairs[k] + v : v)
	out = 
	for k,v in PolymerPairs
		out .= k " " v "`n"
	step := A_Index
	ShowOutput()
}

PolymerSingles := []
for k,v in PolymerPairs {
	left_char := SubStr(k,1,1)
	PolymerSingles[left_char] := (PolymerSingles[left_char] ? PolymerSingles[left_char] + v : v)
}
last_char := SubStr(polymer_template, 0, 1)
PolymerSingles[last_char] := (PolymerSingles[last_char] ? PolymerSingles[last_char] + 1 : 1)

for k,v in PolymerSingles {
	if(A_Index == 1)
		least_common := most_common := v
	else {
		least_common := Min(v, least_common)
		most_common := Max(v, most_common)
	}
}
element_range := most_common - least_common

ShowOutput("msgbox")

ExitApp

ShowOutput(type:="tooltip") {
	global
	output = Element Range: %element_range%`n`nPolymer Template: %polymer_template%`nInsertion Rules Count: %irc%`nAfter step %step%:`n%out%
	if(type == "tooltip")
		ToolTip % output
	if(type == "msgbox") {
		ToolTip
		MsgBox % output
	}
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
