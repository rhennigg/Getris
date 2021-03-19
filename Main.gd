extends Node2D

onready var shape1=preload("res://Shape1.tscn")
onready var shape2=preload("res://Shape2.tscn")
onready var shape3=preload("res://Shape3.tscn")
onready var shape4=preload("res://Shape4.tscn")
onready var shape5=preload("res://Shape5.tscn")
onready var shape6=preload("res://Shape6.tscn")
onready var shape7=preload("res://Shape7.tscn")
var shapes=[]
var sh
var active_block=false
var rnd=RandomNumberGenerator.new()
var num:int=-1
var next_num:int=0

func _ready():
	shapes=[shape1,shape2,shape3,shape4,shape5,shape6,shape7]
	rnd.randomize()

func _on_Timer_timeout():
	$Timer.wait_time=Globals.speed
	if not active_block:
		num=rnd.randi()%7 if num==-1 else next_num
		next_num=rnd.randi()%7
		$NextShapePanel/VBoxContainer/Control/Sprite.frame=next_num
		sh=shapes[num].instance()
		$ShapesArea.add_child(sh)
		sh.position=Vector2(320,80)
		active_block=true
	else:
		move_down()

func move_left():
	if active_block:
		sh.move_left()

func move_right():
	if active_block:
		sh.move_right()

func move_down():
	if active_block:
		sh.move_down()
		$Timer.start()

func _input(event):
	if sh:
		if Input.is_action_just_pressed("ui_right"):
			move_right()
		if Input.is_action_just_pressed("ui_left"):
			move_left()
		if Input.is_action_just_pressed("ui_down"):
			move_down()
		if Input.is_action_just_pressed("ui_up"):
			sh.rotate_it()
