extends StaticBody2D


var can_drag = false
var mouse_offset
var lmps = []

func _ready():
	for i in 5:
		lmps.append(get_global_mouse_position())


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "position", get_global_mouse_position(), 0.2)
		tween.tween_callback(self.enable_drag)

func enable_drag():
	can_drag = true

func _process(delta):
	lmps.remove_at(0)
	lmps.append(get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or can_drag:

		print(mouse_offset)
		#mouse_offset *= -1
		print(mouse_offset)
		position = lmps[0]
