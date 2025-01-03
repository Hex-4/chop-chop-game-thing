extends Node2D

@onready var team_node: Node = $".."
var hearts = 3:
	get:
		return hearts
	set(value):
		if hearts != value:
			change_visible_hearts(value)
		hearts = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func change_visible_hearts(new_value):
	var diff = new_value - hearts
	if diff > 0:
		var tween = get_tree().create_tween()
		for i in range(0,diff):
			tween.tween_property(get_node(str(new_value - i)), "scale", Vector2(0,0), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)

func increase_hearts():
	hearts += 1
	
func decrease_hearts():
	hearts -= 1
