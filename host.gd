extends Node2D

func _ready() -> void:
	mp.host = self
	
	mp.send({
		"t": "NEWROOM"
	})
	
func got_room(m):
	if m["code"]:
		mp.code = m["code"]
		$"Code".text = m["code"]
		$"PlayerList".add_item(m["id"], null, false)
		mp.player_id = m["id"]
		
func new_player(m):
	$"PlayerList".add_item(m["id"], null, false)

func _on_button_pressed() -> void:
	mp.send({
		"t": "START",
		"code": mp.code
	})
