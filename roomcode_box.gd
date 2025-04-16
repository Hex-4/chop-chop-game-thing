extends HBoxContainer

func _on_button_pressed() -> void:
	mp.code = $"LineEdit".text
	
	mp.send({
		"t": "JOIN",
		"code": $"LineEdit".text
	})
	
