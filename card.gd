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
var prev_pos
var animating = false
var prev_can_drag = false
var active
@onready var manager = $"../.."

@export var team = 0

@onready var sprite = $Testcard

@export var number = 1

signal played

func _ready():
	sprite.animation = str(number)
	played.connect(manager.card_played)


func _process(delta):
	#print("canDrag: " + str(canDrag))
	#print("prev canDrag:" + str(prev_can_drag))
	if canDrag:
		
		$".".global_position = lerp($".".global_position, get_global_mouse_position(), 8 * delta)


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseMotion or InputEventMouseButton:
		if event is InputEventMouseButton and event.double_click:
			print("ATTAC")
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
		elif event is InputEventMouseButton and event.button_mask == 1 and not canDrag and scale == Vector2(1,1):
			var tween = get_tree().create_tween()
			active = true
			tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		else:
			canDrag = false
			#var tween = get_tree().create_tween()
func released():
	overlaps = get_overlapping_areas()
	if scale > Vector2(1,1):
		var tween = get_tree().create_tween()
		active = false
		tween.tween_property(self, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	if overlaps and overlaps[0].is_in_group("card"):
		if overlaps[0].team != team and (not overlaps[0].animating) and (not animating) and (overlaps[0].is_in_group("card")):
			animating = true
			z_index = overlaps[0].z_index + 1
			rotation_degrees = 0
			var target_pos = Vector2(overlaps[0].position.x,overlaps[0].position.y - 3)
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", target_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_interval(0.1)
			tween.tween_property(self, "rotation_degrees", 360, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_interval(0.1)
			tween.tween_callback(do_da_math.bind(self).bind(overlaps[0]))
			
			tween.tween_property(self, "position", prev_pos, 0.4).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_callback(set_animating_to_false)
			tween.tween_callback(played.emit)
		else:
			var tween = get_tree().create_tween()
			tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _on_mouse_entered():
	if (not canDrag) and len(get_overlapping_areas()) == 0 :
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", Vector2(position.x, position.y - 5), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		sprite.play(sprite.animation)
	


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
	

func set_animating_to_false():
	animating = false
