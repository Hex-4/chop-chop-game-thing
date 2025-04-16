extends Button

@export var scene: PackedScene

func _ready() -> void:
	connect("pressed", switch)
	
func switch():
	get_tree().change_scene_to_packed(scene)
