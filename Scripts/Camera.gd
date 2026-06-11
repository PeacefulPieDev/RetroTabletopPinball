extends Camera3D

@export var move_speed: float = 10.0
@export var rotation_speed: float = 0.3

func _process(delta: float) -> void:
	#var move_input := Input.get_vector("camera_left", "camera_right", "camera_backward", "camera_forward")
	var move_input := Input.get_vector("camera_right", "camera_left", "camera_backward", "camera_forward")

	if move_input.length() > 0:
		var direction := Vector3(move_input.x, 0, move_input.y).normalized()
		position += direction * move_speed * delta

	#var look_input := Input.get_vector("camera_lookleft", "camera_lookright", "camera_down", "camera_up")
	var look_input := Input.get_vector("camera_lookright", "camera_lookleft", "camera_down", "camera_up")

	if look_input.length() > 0:
		rotate_y(look_input.x * rotation_speed * delta)
		rotate_x(-look_input.y * rotation_speed * delta)
