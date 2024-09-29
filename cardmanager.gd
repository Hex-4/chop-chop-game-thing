extends Node2D


@export var bottom_team: Node2D
@export var top_team: Node2D
@export var playing: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = bottom_team


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func card_played():
	if playing == bottom_team:
		playing = top_team
	elif playing == top_team:
		playing = bottom_team
	
