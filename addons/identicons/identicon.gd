@tool

class_name Identicon
extends Node2D

@export var code: int:
	set(value):
		if code==posmod(value,4294967296):
			return
		code=posmod(value,4294967296)
		queue_redraw()

const patch0=[Vector2(0,0),Vector2(1,0),Vector2(1,1),Vector2(0,1)]
const patches=[patch0,[Vector2(0,0),Vector2(1,0),Vector2(0,1)],[Vector2(0.5,0),Vector2(1,1),Vector2(0,1)],[Vector2(0,0),Vector2(0.5,0),Vector2(0.5,1),Vector2(0,1)],[Vector2(0.5,0),Vector2(0,0.5),Vector2(0.5,1),Vector2(1,0.5)],[Vector2(0,0),Vector2(1,0.5),Vector2(1,1),Vector2(0.5,1)],[Vector2(0.5,0),Vector2(1,1),Vector2(0.5,1),Vector2(0.75,0.5),Vector2(0.25001,0.5),Vector2(0.49999,1),Vector2(0,1)],[Vector2(0,0),Vector2(1,0.5),Vector2(0.5,1)],[Vector2(0.25,0.25),Vector2(0.75,0.25),Vector2(0.75,0.75),Vector2(0.25,0.75)],[Vector2(1,0),Vector2(0,1),Vector2(0,0.5),Vector2(0.5,0.5),Vector2(0.5,0)],[Vector2(0,0),Vector2(0.5,0),Vector2(0.5,0.5),Vector2(0,0.5)],[Vector2(0,0.5),Vector2(1,0.5),Vector2(0.5,1)],[Vector2(0,1),Vector2(0.5,0.5),Vector2(1,1)],[Vector2(0,0.5),Vector2(0.5,0),Vector2(0.5,0.5)],[Vector2(0,0),Vector2(0.5,0),Vector2(0,0.5)],patch0]
const centralPatches=[0,4,8,15]

func draw_patch(pos,type,inv,turn,fore,back):
	if type==15:
		inv=not inv
	draw_set_transform(pos/3-(Vector2.ONE/6).rotated(turn*PI/2)+Vector2.ONE/6,turn*PI/2,Vector2.ONE/3)
	if inv:
		draw_rect(Rect2(Vector2.ZERO,Vector2.ONE),fore)
		draw_colored_polygon(patches[type],back)
	else:
		draw_rect(Rect2(Vector2.ZERO,Vector2.ONE),back)
		draw_colored_polygon(patches[type],fore)

func _draw():
	var centralType=centralPatches[code&3]
	var centralInvert=code>>2&1
	var cornerType=code>>3&15
	var cornerInvert=code>>7&1
	var cornerTurn=code>>8&3
	var edgeType=code>>10&15
	var edgeInvert=code>>14&1
	var edgeTurn=code>>15&3
	var foreColor=Color8(code>>24&248,code>>18&248,code>>13&248)
	var backColor=Color(1,1,1)
	draw_patch(Vector2(1,1),centralType,centralInvert,0,foreColor,backColor)
	
	draw_patch(Vector2(0,0),cornerType,cornerInvert,cornerTurn,foreColor,backColor)
	draw_patch(Vector2(2,0),cornerType,cornerInvert,cornerTurn+1,foreColor,backColor)
	draw_patch(Vector2(2,2),cornerType,cornerInvert,cornerTurn+2,foreColor,backColor)
	draw_patch(Vector2(0,2),cornerType,cornerInvert,cornerTurn+3,foreColor,backColor)
	
	draw_patch(Vector2(1,0),edgeType,edgeInvert,edgeTurn,foreColor,backColor)
	draw_patch(Vector2(2,1),edgeType,edgeInvert,edgeTurn+1,foreColor,backColor)
	draw_patch(Vector2(1,2),edgeType,edgeInvert,edgeTurn+2,foreColor,backColor)
	draw_patch(Vector2(0,1),edgeType,edgeInvert,edgeTurn+3,foreColor,backColor)
