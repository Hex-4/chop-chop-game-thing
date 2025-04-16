extends Node2D


func _ready() -> void:
	mp.waiter = self
	refresh(mp.joinx)

func refresh(m):
	print("UPDATING!!!!")
	$PlayerList.clear()
	for p in m["list"]:
		$PlayerList.add_item(p)
