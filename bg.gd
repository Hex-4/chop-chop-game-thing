extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var cards = get_tree().get_nodes_in_group("card")
		for i in cards:
			if i.scale > Vector2(1,1):
				var tween = get_tree().create_tween()
				i.active = false
				tween.tween_property(i, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			
