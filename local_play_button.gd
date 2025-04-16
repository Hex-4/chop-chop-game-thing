extends Button


func _on_pressed() -> void:
	mp.multiplayer_mode = false
	get_tree().change_scene_to_file("res://dragging.tscn")
