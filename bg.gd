extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1 and viewport.is_input_handled() == false:
		print("BG CLICKED!")
		
