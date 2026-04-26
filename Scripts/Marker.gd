extends RigidBody3D

@export var route: Route
@export var currentIndex: int = 0

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_M:
			var tween = create_tween()
			var roll = randi_range(1, 6)
			for i in range(1, roll + 1):
				tween.tween_property(self, "position", route.getCheckpointByIndex(currentIndex + i).position, 0.4)
			currentIndex += roll
			
			
		
