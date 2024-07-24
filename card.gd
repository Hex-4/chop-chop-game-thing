extends StaticBody2D




# modified code from gemmomoh on godot forums
var canDrag = false
var cards_that_are_not_being_dragged = []


func _process(delta):
	print(self)
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
				canDrag = true
				z_index = 100
				
				
				
			
			
		else:
			z_index = 0
			canDrag = false
