#NoEnv
#SingleInstance Force

;input_fn := "aoc2021_17_test_input.txt"
input_fn := "aoc2021_17_input.txt"

FileRead, file, %input_fn%
file := RegExReplace(file, "`r")

Loop, Parse, file, `n
{
	line := A_LoopField
	RegExMatch(line, "^target area: x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)$", m)
	x1 := m1
	x2 := m2
	y1 := m3
	y2 := m4
}
if(x1 < 0 or x2 < 0)
	MsgBox, Need to program for negative x values!`nx1: %x1%`nx2: %x2%
if(y1 > 0 or y2 > 0)
	MsgBox, Need to program for negative x values!`ny1: %y1%`ny2: %y2%

XVelocity := []
x_miss =
Loop % x2+1 {
	xv_init := A_Index
	x := 0
	xv := xv_init
	Loop {
		x += xv
		if(x >= x1 and x <= x2) {
			XVelocity[xv_init] := 1
			break
		}
		xv += (xv > 0 ? -1 : (xv < 0 ? 1 : 0))
		if(!xv) {
			if(x < x1)
				x_too_slow .= xv_init " "
			if(x > x2)
				x_too_fast .= xv_init " "
			break
		}
	}
}
for k,v in XVelocity
	x_potential .= k ":" v " "
;MsgBox % "XVelocity:`nToo Slow: " x_too_slow "`nToo Fast: " x_too_fast "+`nPotential: " x_potential


YVelocity := []
Loop % -y1+1 {
	yv_init := A_Index
	y := 0
	yv := yv_init
	y_max := 0
	Loop {
		y += yv
		y_max := Max(y, y_max)
		if(y >= y1 and y <= y2) {
			YVelocity[yv_init] := y_max
			break
		}
		yv--
		if(y < y1) {
			y_too_fast .= yv_init " "
			break
		}
	}
}
for k,v in YVelocity
	y_potential .= k ":" v " "
;MsgBox % "YVelocity:`nToo Fast: " y_too_fast "+`nPotential: " y_potential

highest_y := 0
for k,v in YVelocity {
	for kk,vv in XVelocity {
		;MsgBox, YVelocity`nk: %k%`nv: %v%`n`nXVelocity`nkk: %kk%`nvv: %vv%
		x := 0
		y := 0
		xv_init := kk
		yv_init := k
		xv := xv_init
		yv := yv_init
		y_max_testing := 0
		;MsgBox, A_Index: %A_Index%`ncoords: (%x%,%y%)`nvel: (%xv%,%yv%)`ny_max_testing: %y_max_testing%
		Loop {
			x += xv
			y += yv
			y_max_testing := Max(y, y_max_testing)
			;MsgBox, A_Index: %A_Index%`ncoords: (%x%,%y%)`nvel: (%xv%,%yv%)`ny_max_testing: %y_max_testing%
			if(x >= x1 and y >= y1 and x <= x2 and y <= y2) {
				initial_velocity_count++
				last_highest_y := highest_y
				highest_y := Max(y_max_testing, highest_y)
				if(highest_y > last_highest_y) {
					highest_y_progression .= "(" xv_init "," yv_init "):" highest_y "`n"
					ShowOutput()
					;ShowOutput("msgbox")
				}
				break
			}
			if(y < y1)
				break
			xv += (xv > 0 ? -1 : (xv < 0 ? 1 : 0))
			yv--
		}
		;ShowOutput()
	}
}

ShowOutput("msgbox")

ExitApp

ShowOutput(type:="tooltip") {
	global
	output = Highest Y Position: %highest_y%`nDistinct Initial Velocities: %initial_velocity_count%`nInitial Velocity: (%xv_init%,%yv_init%)`nTesting Max: %y_max_testing%`n`n%highest_y_progression%
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

Pad(raw, width, padding:="0") {
	padded := raw
	while(StrLen(padded) < width)
		padded := padding padded
	return padded
}

CountChar(string, char) {
	return StrLen(RegExReplace(string, "[^" char "]"))
}


Pow(pow_base, pow_exp) {
	prod := 1
	Loop, %pow_exp%
		prod *= pow_base
	return prod
}