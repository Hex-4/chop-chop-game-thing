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
@onready var prev_pos = position
var animating = false
var prev_can_drag = false
var active
@onready var manager = $"../.."

@export var team = 0

@onready var sprite = $Testcard

@export var broken = false

var hearts: Node2D
var enemy_hearts: Node2D

@export var number = 1

@export var enemy_cards: Array[Node2D]

signal played

func _ready():
	sprite.animation = str(number)
	played.connect(manager.card_played)
	if team == 0:
		hearts = $"../Hearts Bottom"
		enemy_hearts = $"../../Top team/Hearts Top"
	elif team == 1:
		hearts = $"../Hearts Top"
		enemy_hearts = $"../../Bottom team/Hearts Bottom"
	print(name + str(position))
	


func _process(delta):
	#print("canDrag: " + str(canDrag))
	#print("prev canDrag:" + str(prev_can_drag))
	if canDrag:
		
		$".".global_position = lerp($".".global_position, get_global_mouse_position(), 8 * delta)


func _input(event):
	if not manager.ended:
		if (event is InputEventMouseMotion or event is InputEventMouseButton) and ((manager.playing.name == "Bottom team") or not mp.multiplayer_mode):
			var shape_global_rect = $CollisionShape2D.shape.get_rect()
			shape_global_rect = Rect2(shape_global_rect.position + position, shape_global_rect.size)
			if shape_global_rect.has_point(event.position):
				
				if event is InputEventMouseButton and event.double_click and (get_parent() == manager.playing):
					if not broken and mp.multiplayer_mode:
						var r = {
							"t": "ATK",
							"code": mp.code,
							"card": int(str(name)[-1]) - 1, # Get last character of name, turn that into an int and subtract 1 so it's zero based
							"id": mp.player_id
						}
						mp.send(r)
					attac()
					print(self)
				if event.button_mask == 1 and (get_parent() == manager.playing) and event is InputEventMouseMotion:
					cards_that_are_not_being_dragged = []
					for i in get_tree().get_nodes_in_group("card"):
						if i.canDrag == false or i == self:
							cards_that_are_not_being_dragged.append(i)
					if len(cards_that_are_not_being_dragged) == len(get_tree().get_nodes_in_group("card")):
						if canDrag == false:
							prev_pos = position
						canDrag = true
						
						z_index = 1000
				elif event is InputEventMouseButton and event.button_mask == 1 and not canDrag:
					var active_card: Node = null
					if get_tree():
						for i in get_tree().get_nodes_in_group("card"):
							if i.active:
								active_card = i
								break
						if active_card:
							print(active_card)
							if not active_card == self:
								active_card.swap(self)
								if active_card.team != team and mp.multiplayer_mode:
									var r = {
										"t": "SWAP",
										"code": mp.code,
										"to": int(str(name)[-1]) - 1, # Get last character of name, turn that into an int and subtract 1 so it's zero based
										"from": int(str(active_card.name)[-1]) - 1, # You are very lucky that past you thought to comment this code.
										"id": mp.player_id
									}
									 
									mp.send(r)
								var tween = get_tree().create_tween()
								active = false
								tween.tween_property(self, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
							else:
								if scale > Vector2(1,1):
									var tween = get_tree().create_tween()
									active = false
									tween.tween_property(self, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
								
						
						elif (get_parent() == manager.playing):
							var tween = get_tree().create_tween()
							print("card clicked")
							active = true
							tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				elif not event.is_pressed():
					canDrag = false
					#var tween = get_tree().create_tween()
				overlaps = get_overlapping_areas()
				overlaps = overlaps.filter(remove_non_cards)
				if not len(overlaps) > 0:
					if get_viewport():
						get_viewport().set_input_as_handled()
		
func released():
	var first_card
	print("Released!")
	overlaps = get_overlapping_areas()
	overlaps = overlaps.filter(remove_non_cards)
	if overlaps:
		first_card = overlaps[0]
	else:
		first_card = null
	if scale > Vector2(1,1):
		var tween = get_tree().create_tween()
		active = false
		tween.tween_property(self, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	swap(first_card)
	if first_card and first_card.team != team and mp.multiplayer_mode:
		var r = {
			"t": "SWAP",
			"code": mp.code,
			"from": int(str(name)[-1]) - 1, # Get last character of name, turn that into an int and subtract 1 so it's zero based
			"to": int(str(first_card.name)[-1]) - 1, # You are very lucky that past you thought to comment this code.
			"id": mp.player_id
		}
		 
		mp.send(r)
	


func _on_mouse_entered():
	if (not canDrag) and len(get_overlapping_areas().filter(remove_non_cards)) == 0 :
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", Vector2(position.x, position.y - 5), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		sprite.play(sprite.animation)
	

func swap(card: Node):
	if card:
		print("swapping - there's a card!")
		if card.team != team and (not card.animating) and (not animating):
			animating = true
			z_index = card.z_index + 1
			rotation_degrees = 0
			var target_pos = Vector2(card.position.x,card.position.y - 3)
			var tween = get_tree().create_tween()
			if scale > Vector2(1,1):
				tween.tween_property(self, "scale", Vector2(1,1), 0.05).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "position", target_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_interval(0.1)
			tween.tween_property(self, "rotation_degrees", 360, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_interval(0.1)
			tween.tween_callback(do_da_math.bind(self).bind(card))
			
			tween.tween_property(self, "position", prev_pos, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_callback(set_animating_to_false)
			
			tween.tween_callback(become_inactive)
			tween.tween_callback(played.emit)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_mouse_exited():
	if not canDrag:
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", Vector2(position.x, position.y + 5), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		sprite.play_backwards(sprite.animation)
		
func do_da_math(card1, card2):
	var num1: int = card1.sprite.animation.to_int()
	var num2: int = card2.sprite.animation.to_int()
	print(num1 + num2)
	var sum
	if num1 + num2 > 9:
		sum = (num1 + num2) - 10
	else:
		sum = num1 + num2
	card2.sprite.animation = str(sum)
	card2.broken = false
	card2.modulate = Color(1,1,1)
	card2.number = sum
	

func set_animating_to_false():
	animating = false
	
func remove_non_cards(o):
	if o.is_in_group("card"):
		return true
	else:
		return false
		
func become_inactive():
	active = false
	
func attac():
	if not broken:
		
		
		if number == 7 or number == 9:
			check_shield()
			become_broken()
		elif number == 6 and hearts.hearts < 3:
			print("healing!")
			hearts.increase_hearts()
			become_broken()

func become_broken():
	if get_tree():
		
		broken = true
		var tween = get_tree().create_tween()
		active = false
		
		tween.tween_property(self, "modulate", Color(15,15,15, 1), 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # Fade to white
		tween.tween_callback(change_to_broken_sprite)
		tween.tween_property(self, "modulate", Color.from_hsv(1,0,0.3), 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		
		tween.tween_property(self, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_callback(played.emit)

	
func change_to_broken_sprite():
	sprite.animation = str(number) + "b"

func check_shield():
	var enemy_shield: Node2D = null
	for c in enemy_cards:
		if c.number == 5 and c.broken == false:
			enemy_shield = c
			break
	if enemy_shield:
		enemy_shield.become_broken()
	else:
		print("Check_shield():")
		print(self)
		enemy_hearts.decrease_hearts()
		check_end()

func check_end():
	if hearts.hearts <= 0:
		if team == 0:
			manager.ended = true
			get_tree().change_scene_to_file("res://top_win.tscn")
			
		elif team == 1:
			manager.ended = true
			get_tree().change_scene_to_file("res://bottom_win.tscn")
	elif enemy_hearts.hearts <= 0:
		if team == 1:
			manager.ended = true
			get_tree().change_scene_to_file("res://top_win.tscn")
		elif team == 0:
			manager.ended = true
			get_tree().change_scene_to_file("res://bottom_win.tscn")
