extends Area2D




# modified code from gemmomoh on godot forums
var canDrag = false:
	get:
		return canDrag
	set(value):
		if canDrag == true and value == false:
			released()
		canDrag = value
var cards_that_are_not_being_dragged = []
var overlaps
var prev_pos
var prev_can_drag = false

@onready var sprite = $Testcard

func _process(delta):
	#print("canDrag: " + str(canDrag))
	#print("prev canDrag:" + str(prev_can_drag))
	if canDrag:
		
		$".".global_position = lerp($".".global_position, get_global_mouse_position(), 8 * delta)


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion or InputEventMouseButton:
		if event.button_mask == 1:
			cards_that_are_not_being_dragged = []
			for i in get_tree().get_nodes_in_group("card"):
				if i.canDrag == false or i == self:
					cards_that_are_not_being_dragged.append(i)
			if len(cards_that_are_not_being_dragged) == len(get_tree().get_nodes_in_group("card")):
				if canDrag == false:
					prev_pos = position
				print(prev_pos)
				canDrag = true
				z_index = 1000
		else:
			
			canDrag = false
			#var tween = get_tree().create_tween()
			#tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		get_viewport().set_input_as_handled()
func released():
	overlaps = get_overlapping_areas()
	if overlaps:
		z_index = overlaps[0].z_index + 1
		rotation_degrees = 0
		var target_pos = Vector2(overlaps[0].position.x,overlaps[0].position.y - 3)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", 360, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_interval(0.1)
		tween.tween_property(self, "position", prev_pos, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", prev_pos, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_mouse_entered():
	if (not canDrag) and len(get_overlapping_areas()) == 0 :
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", Vector2(position.x, position.y - 5), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		sprite.play("hover")
	


func _on_mouse_exited():
	if not canDrag:
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", Vector2(position.x, position.y + 5), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		sprite.play_backwards("hover")
