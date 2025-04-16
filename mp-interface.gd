extends Node
@export var server_url = "wss://relay.hex4.hackclub.app:443" # Hack Club Nest
var socket = WebSocketPeer.new()
var manager: Node
var host: Node
var waiter: Node
var joinx: Dictionary
var startx: Dictionary
var code
var player_id
var multiplayer_mode: bool

func _ready():
	# Initiate connection to the given URL.
	var err = socket.connect_to_url(server_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
	else:
		# Wait for the socket to connect.
		await get_tree().create_timer(2).timeout

		
func _process(delta: float) -> void:
	socket.poll()
	
	# get_ready_state() tells you what state the socket is in.
	var state = socket.get_ready_state()

	# WebSocketPeer.STATE_OPEN means the socket is connected and ready
	# to send and receive data.
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var message = JSON.parse_string(socket.get_packet().get_string_from_utf8())
			print(message)
			match message["t"]:
				"JOINX":
					get_tree().change_scene_to_file("res://waiting.tscn")
					
					joinx = message
					
					player_id = message["id"]
					
					
					
					#if manager:
						#manager.player_id = message["id"]
						#manager.players = message["list"] # FIXME: Is not updated when players join
						#if not message["first"]:
							#manager.card_played()
						#print("Joined game as " + manager.player_id)
				"HJOINX":
					if host:
						host.new_player(message)
					if waiter:
						waiter.refresh(message)
				"SWAPX":
					if message["id"] != player_id:
						manager.remote_swap(message)
				"ATKX":
					if (message["id"] != player_id) and manager:
						manager.remote_attack(message)
				"COMBOX":
					if (message["id"] != player_id) and manager:
						manager.remote_combo(message)
				"NEWROOMX":
					if host:
						host.got_room(message)
				"STARTX":
					get_tree().change_scene_to_file("res://dragging.tscn")
					multiplayer_mode = true
					startx = message
				

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
		
func send(dict):
	print("sending:\n"+JSON.stringify(dict))
	socket.send_text(JSON.stringify(dict))
