extends Node2D


@export var bottom_team: Node2D
@export var top_team: Node2D
@export var playing: Node
var ended = false


# Called when the node enters the scene tree for the first time.
func _ready():
	playing = bottom_team
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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
			
	
	
