extends Node2D
var cards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for card in get_children():
		if card.is_in_group("card"):
			cards.append(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(len(cards))
	
	for card in cards:
		card.prev_can_drag = card.canDrag
		if card.prev_can_drag == true and card.canDrag == false:
			released_card(card)


func released_card(card):
	print("RELEASED")
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", card.prev_pos, 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
