extends TextureButton

@export var team_node: Node2D

@export var hearts: Node2D

@export var ehearts: Node2D

@onready var manager = $"../.."

@onready var flash = $"../../Flash"

var enemy_node

var center_pos_x

var cards

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().name == "Top team":
		center_pos_x = 604
		enemy_node = $"../../Bottom team"
	elif get_parent().name == "Bottom team":
		center_pos_x = 600
		enemy_node = $"../../Top team"
	cards = team_node.get_children().filter(remove_non_cards)
	check_combo()
	if get_parent().name == "Top team":
		disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func remove_non_cards(o):
	if o.is_in_group("card"):
		return true
	else:
		return false

func _on_pressed() -> void:
	if mp.multiplayer_mode:
		var r = {
			"t": "COMBO",
			"code": mp.code,
			"id": mp.player_id
		}
		mp.send(r)
	resolve_combo()

func resolve_combo():
	if get_parent() == manager.playing:
		print("hi")
		var n = team_node
		var cards = n.get_children().filter(remove_non_cards)
		if cards[0].number == 8 and cards[1].number == 8: # Nuke
			for c in cards:
				var t = get_tree().create_tween()
				t.tween_property(c, "position", Vector2(center_pos_x, c.position.y), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT) # Move to center
				t.parallel().tween_property(c, "modulate", Color(20,20,20, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
				t.tween_callback(change_to_nuke.bind(c))
				t.tween_property(c, "modulate", Color(1,1,1, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				if c.name == "top 1" or c.name == "bottom 1": # Only one card needs to do this
					t.tween_property(flash, "color", Color(1,1,1,1), 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Screen flash
					t.tween_callback(change_to_eight)
					t.tween_callback(change_enemy_cards_to_one)
					
					t.tween_property(flash, "color", Color(1,1,1,0), 2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Screen flash
				else:
					t.tween_interval(2.3)
				t.tween_property(c, "position", c.position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
				t.tween_callback(played.bind(c))
		if cards[0].number == 0 and cards[1].number == 0: # Laser
			for c in cards:
				var t = get_tree().create_tween()
				t.tween_property(c, "position", Vector2(center_pos_x, c.position.y), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT) # Move to center
				t.parallel().tween_property(c, "modulate", Color(20,20,20, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
				t.tween_callback(change_to_nuke.bind(c))
				t.tween_property(c, "modulate", Color(1,1,1, 1), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				if c.name == "top 1" or c.name == "bottom 1": # Only one card needs to do this
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					t.tween_callback(remove_eheart)
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					t.tween_callback(remove_eheart)
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					t.tween_callback(remove_eheart)
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
					t.tween_callback(c.check_end)
				else:
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
					t.tween_property(c, "modulate", Color(20,20,20, 1), 0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
					
					t.tween_property(c, "modulate", Color(1,1,1, 1), 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
					t.tween_interval(0.7)
			
				
func remove_eheart():
	ehearts.hearts -= 1
# SECTION: STUFF FOR THE NUKE
func change_to_nuke(card):
	card.sprite.animation = "nuke"
func change_to_eight():
	for i in cards:
		i.sprite.animation = str(8)
		i.broken = false
		i.modulate = Color(1,1,1)
		i.number = 8
	
func change_enemy_cards_to_one():
	var ecards = enemy_node.get_children().filter(remove_non_cards)
	for i in ecards:
		i.sprite.animation = str(1)
		i.broken = false
		i.modulate = Color(1,1,1)
		i.number = 1
	for i in cards:
		i.sprite.animation = str(1)
		i.broken = false
		i.modulate = Color(1,1,1)
		i.number = 1
	
func played(c):
	if c.name == "top 1" or c.name == "bottom 1":
		manager.card_played()
		
		

	

func check_combo():
	print("Checking!")
	var cards = team_node.get_children().filter(remove_non_cards)
	if get_parent() == manager.playing: 
		disabled = true # Force disable if not playing
	elif cards[0].number == 5 and cards[1].number == 5: # 5+5 -> Invisible shield
		disabled = false
	elif cards[0].number == 6 and cards[1].number == 6: # 6+6 -> Invisible potion
		disabled = false
	elif (cards[0].number == 7 and cards[1].number == 6) or (cards[0].number == 6 and cards[1].number == 7): # 6+7 or 7+6 -> Crossbow
		disabled = false
	elif cards[0].number == 8 and cards[1].number == 8: # 8+8 -> NUKE
		disabled = false
	elif cards[0].number == 0 and cards[1].number == 0: # 0+0 -> Lasers!
		disabled = false
	
	
	
