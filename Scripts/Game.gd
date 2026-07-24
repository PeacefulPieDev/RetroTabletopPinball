extends Node3D

var players = ["First"]
var player_panels = []
var player_markers = []
var colors = [Color.RED, Color.YELLOW, Color.GREEN, Color.BLUE, Color.PURPLE]

func _ready():
	var first_panel = $CanvasLayer/VBoxContainer_Players/HBoxContainer_Player
	player_panels.append(first_panel)
	var first_color_rect = first_panel.get_node("ColorRect")
	if first_color_rect:
		first_color_rect.color = colors[0 % colors.size()]

	var first_marker = $Arena/Marker
	player_markers.append(first_marker)

func _on_button_add_pressed():
	var player_num = players.size() + 1
	var new_player = "Player" + str(player_num)
	players.append(new_player)

	var new_panel = player_panels[0].duplicate()
	new_panel.name = "HBoxContainer_Player_" + new_player
	$CanvasLayer/VBoxContainer_Players.add_child(new_panel)
	player_panels.append(new_panel)

	var color = colors[(players.size() - 1) % colors.size()]
	var color_rect = new_panel.get_node("ColorRect")
	if color_rect:
		color_rect.color = color

	var new_marker = player_markers[0].duplicate()
	new_marker.name = "Marker_" + new_player
	$Arena.add_child(new_marker)
	player_markers.append(new_marker)
	new_marker.set_color(color)


func _on_button_remove_pressed():
	if players.size() <= 1:
		return
	players.remove_at(players.size() - 1)
	var last_panel = player_panels[player_panels.size() - 1]
	last_panel.queue_free()
	player_panels.remove_at(player_panels.size() - 1)
	var last_marker = player_markers[player_markers.size() - 1]
	last_marker.queue_free()
	player_markers.remove_at(player_markers.size() - 1)
