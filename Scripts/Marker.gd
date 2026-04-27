extends RigidBody3D

@export var route: Route
@onready var currentCheckpoint: int = 1

func _ready():
	for hole in get_tree().get_nodes_in_group("Holes"):
		hole.connect("hole_triggered", _on_hole_triggered)
			
func _on_hole_triggered(points: int):
	print("[Marker] Points received: ", points)
	var tween = create_tween()
	for i in range(currentCheckpoint, currentCheckpoint + points):
		tween.tween_property(self, "position", route.getCheckpointByIndex(i).position, 0.4)
	currentCheckpoint += points
