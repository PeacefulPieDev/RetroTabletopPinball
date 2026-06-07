extends RigidBody3D

class_name Marker

@onready var route: Route = $"../Routes".get_node("Route_Main")
@onready var currentCheckpoint: int = 0

func _ready():
	for hole in get_tree().get_nodes_in_group("Holes"):
		hole.connect("hole_triggered", _on_hole_triggered)

func _on_hole_triggered(points: int):
	print("[Marker] Points received: ", points)
	currentCheckpoint += 1
	var tween = create_tween()
	tween.tween_property(self, "position", route.getCheckpointByIndex(currentCheckpoint).position, 0.4)
	tween.tween_callback(_on_movement_finished.bind(points - 1))

func _input(event):
	if event is InputEventKey and not event.pressed:
#Cheat:
		match event.keycode:
			KEY_KP_1: _on_hole_triggered(1)
			KEY_KP_2: _on_hole_triggered(2)
			KEY_KP_3: _on_hole_triggered(3)
			KEY_KP_4: _on_hole_triggered(4)
			KEY_KP_5: _on_hole_triggered(5)
			KEY_KP_6: _on_hole_triggered(6)
			KEY_KP_7: _on_hole_triggered(7)
			KEY_KP_8: _on_hole_triggered(8)
			KEY_KP_9: _on_hole_triggered(9)

func _on_movement_finished(pointsLeft:int):
	var checkpoint = route.getCheckpointByIndex(currentCheckpoint) as Checkpoint

	if checkpoint.exit_checkpoint:
		route = checkpoint.exit_checkpoint.get_parent().get_parent()
		currentCheckpoint = checkpoint.exit_checkpoint.index - 1

	if pointsLeft > 0:
		_on_hole_triggered(pointsLeft)
		return

	if checkpoint.skip_turn:
		pass
	elif checkpoint.jump_checkpoint:
		var tween = create_tween()
		tween.tween_property(self, "position", checkpoint.jump_checkpoint.position, 3)
		currentCheckpoint = checkpoint.jump_checkpoint.index - 1
	elif checkpoint.secondary_route:
		route = checkpoint.secondary_route
		currentCheckpoint = -1 # not 0 becuase secondary route doesn't include first checkpoint

#Cheat:
func _on_button_button_up() -> void:
	var target = int($"../../CanvasLayer/HBoxContainer/LineEdit".text)
	currentCheckpoint = target - 1
	position = $"../Routes".get_node("Route_Main").getCheckpointByIndex(currentCheckpoint).position
