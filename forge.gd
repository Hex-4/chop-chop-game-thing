extends TextureButton

@export var team_node: Node2D

@onready var manager = $"../.."

var center_pos_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().name == "Top team":
		center_pos_x = 604
	elif get_parent().name == "Bottom team":
		center_pos_x = 600


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove_non_cards(o):
	if o.is_in_group("card"):
		return true
	else:
		return false

func _on_pressed() -> void:
	if get_parent() == manager.playing:
		var n = team_node
		var cards = n.get_children().filter(remove_non_cards)
		for c in cards:
			var t = get_tree().create_tween()
			t.tween_property(c, "position", Vector2(center_pos_x, c.position.y), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT) # Move to center
			t.parallel().tween_property(c, "modulate", Color(20,20,20, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
			t.tween_callback(set_card.bind(c))
			t.tween_property(c, "position", c.position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
			t.parallel().tween_property(c, "modulate", Color(1,1,1, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			t.tween_callback(played.bind(c))
			
func set_card(c):
	c.sprite.animation = str(4)
	c.broken = false
	c.number = 4
	
func played(c):
	if c.name == "top 1" or c.name == "bottom 1":
		manager.card_played()
		
func check_combo():
	var cards = team_node.get_children().filter(remove_non_cards)
	if get_parent() == manager.playing: 
		disabled = true # Force disable if not playing
	elif cards[0].number == 5 and cards[1].number == 5: # 5+5 -> Invisible shield
		disabled = false
	elif cards[0].number == 6 and cards[1].number == 6: # 6+6 -> Invisible potion
		disabled = false
	elif (cards[0].number == 7 and cards[1].number == 6) or (cards[0].number == 6 and cards[1].number == 7): # 6+7 or 7+6 -> Crossbow
		disabled = false
	elif cards[0].number == 8 and cards[1].number == 8: # 8+8 -> GUNS
		disabled = false
	
	
	
