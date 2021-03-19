extends Node2D

var is_active=false

func _ready():
	is_active=true
	Globals.connect("inact_shape",self,"inactivate_it")

func inactivate_it():
	if is_active:
		get_parent().is_fixed=true
		is_active=false
		get_tree().root.get_node("Main").active_block=false
		Globals.inactive.append(get_parent().position+position)
		Globals.inactive_blocks.append(self)
		Globals.inactivate_shape()
		check_full_line()

func can_rotate(val) -> bool:
	if Globals.inactive.has(Vector2(get_parent().position.x+val.x,get_parent().position.y+val.y)) or is_off_screen(Vector2(get_parent().position.x+val.x,get_parent().position.y+val.y)):
		return false
	else:
		return true

func is_off_screen(vec) -> bool:
	if vec.x<0:
		return true
	elif vec.x>=get_parent().get_parent().get_rect().size.x:
		return true
	elif vec.y<0:
		return true
	elif vec.y>=get_parent().get_parent().get_rect().size.y:
		return true
	else:
		return false

func can_move_down():
	if Globals.inactive.has(Vector2(get_parent().position.x+position.x,get_parent().position.y+position.y+80)) or get_parent().position.y+position.y==1520:
		inactivate_it()
		return false
	else:
		return true

func can_move_left():
	if get_parent().position.x+position.x==0 or (Globals.inactive.has(Vector2(get_parent().position.x+position.x-80,get_parent().position.y+position.y))) or not is_active:
		return false
	else:
		return true

func can_move_right():
	if get_parent().position.x+position.x==720 or (Globals.inactive.has(Vector2(get_parent().position.x+position.x+80,get_parent().position.y+position.y))) or not is_active:
		return false
	else:
		return true

func check_full_line():
	var index=0
	var count=0
	var positions_to_erase=[]
	var blocks_to_shift=[]
	for i in Globals.inactive:
		if i.y==get_parent().position.y+position.y:
			positions_to_erase.append(index)
			count+=1
		index+=1
	if count==10:
		destroy_line(positions_to_erase)
		index=0
		for i in Globals.inactive:
			if i.y<get_parent().position.y+position.y:
				blocks_to_shift.append(index)
			index+=1
		shift_blocks(blocks_to_shift)

func destroy_line(indexes):
	Globals.add_points()
	var line_vals=indexes
	for i in range(line_vals.size()-1,-1,-1):
		Globals.inactive.remove(line_vals[i])
		Globals.inactive_blocks[line_vals[i]].destroy_block()
		Globals.inactive_blocks.remove(line_vals[i])

func shift_blocks(blocks):
	for i in blocks:
		Globals.inactive[i].y+=80
		Globals.inactive_blocks[i].position.y+=80

func destroy_block():
	queue_free()
