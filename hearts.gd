extends Node2D

@onready var team_node: Node = $".."
var hearts: int = 3:
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
	
func change_visible_hearts(new_value: int):
	if new_value < hearts:
		var diff: int = hearts - new_value
		for i in range(diff): 
			var tween = get_tree().create_tween()
			tween.tween_property(get_node(str(hearts - i)), "scale", Vector2(0,0), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # get last heart
			
	if new_value > hearts:
		var diff: int = new_value - hearts
		for i in range(diff): 
			var tween = get_tree().create_tween()
			tween.tween_property(get_node(str(hearts + i + 1)), "scale", Vector2(1,1), 0.2).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT) # get last heart
	

func increase_hearts():
	hearts += 1
	
func decrease_hearts():
	hearts -= 1
