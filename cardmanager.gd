extends Node2D


@export var bottom_team: Node2D
@export var top_team: Node2D
@export var playing: Node
@export var server_url = "ws://localhost:8765"
var ended = false
var socket = WebSocketPeer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	playing = bottom_team
	# Initiate connection to the given URL.
	var err = socket.connect_to_url(server_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout

		# Send data.
		socket.send_text("x")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Call this in _process or _physics_process. Data transfer and state updates
	# will only happen when calling this function.
	socket.poll()

	# get_ready_state() tells you what state the socket is in.
	var state = socket.get_ready_state()

	# WebSocketPeer.STATE_OPEN means the socket is connected and ready
	# to send and receive data.
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			print("Got data from server: ", socket.get_packet().get_string_from_utf8())

	# WebSocketPeer.STATE_CLOSING means the socket is closing.
	# It is important to keep polling for a clean close.
	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	# WebSocketPeer.STATE_CLOSED means the connection has fully closed.
	# It is now safe to stop polling.
	elif state == WebSocketPeer.STATE_CLOSED:
		# The code will be -1 if the disconnection was not properly notified by the remote peer.
		var code = socket.get_close_code()
		print("WebSocket closed with code: %d. Clean: %s" % [code, code != -1])
		set_process(false) # Stop processing.
	
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
			
	
