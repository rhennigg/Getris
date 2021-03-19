extends Shape0
class_name Shape5

func _ready():
	rotation_matrix=[
	[Vector2(-80,0),Vector2(0,0),Vector2(-80,80),Vector2(0,80)],
	[Vector2(-80,0),Vector2(0,0),Vector2(-80,80),Vector2(0,80)],
	[Vector2(-80,0),Vector2(0,0),Vector2(-80,80),Vector2(0,80)],
	[Vector2(-80,0),Vector2(0,0),Vector2(-80,80),Vector2(0,80)]
	]
	draw_shape()
	rotate_position=1
