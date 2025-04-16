extends Node2D


@export var bottom_team: Node2D
@export var top_team: Node2D
@export var playing: Node
@export var server_url = "ws://localhost:8765"
var ended = false

var player_id = null
var players
var top_cards
var bottom_cards


# Called when the node enters the scene tree for the first time.
func _ready():
	playing = bottom_team
	
	mp.manager = self
	
	if mp.multiplayer_mode:
		if not mp.player_id == mp.startx["first"]:
			card_played()
		
	bottom_cards = bottom_team.get_children().filter(remove_non_cards)
	top_cards = top_team.get_children().filter(remove_non_cards)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func remote_swap(message):
	print(mp.player_id + " Swapping!")
	var from = top_cards[message["from"]]
	print("From: " + str(from))
	var to = bottom_cards[message["to"]]
	print("To: " + str(to))
	from.swap(to)
	
func remote_attack(message):
	top_cards[message["card"]].attac()
	
func remote_combo(message):
	$"Top team/TopForge".check_combo()
	$"Top team/TopForge".resolve_combo()
	
func remove_non_cards(o):
	if o.is_in_group("card"):
		return true
	else:
		return false

func card_played():
	
	deactivate_all_cards()
	$"Bottom team/BottomForge".check_combo()
	$"Top team/TopForge".check_combo()
	if playing == bottom_team:
		playing = top_team
	elif playing == top_team:
		playing = bottom_team
	
func deactivate_all_cards() -> void:
	for i in get_tree().get_nodes_in_group("card"):
		if i.active:
			print(i)
			var tween = get_tree().create_tween()
			i.active = false
			tween.tween_property(i, "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			


			
	
