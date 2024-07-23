extends StaticBody2D


var can_drag = false
var mouse_offset

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		mouse_offset = get_global_mouse_position() - position
		mouse_offset *= -1
		can_drag = event.pressed

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_drag:

		print(mouse_offset)
		#mouse_offset *= -1
		print(mouse_offset)
		position = get_global_mouse_position() + mouse_offset
