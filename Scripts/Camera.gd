extends Camera3D

@export var move_speed: float = 10.0
@export var rotation_speed: float = 0.3

@onready var main_dummy: Node3D = $"../CameraMainDummy"
@onready var marker_dummy: Node3D = $"../Arena/Marker/CameraMarkerDummy"

func _ready() -> void:
	main_dummy.position = position
	main_dummy.rotation = rotation
	position = Vector3()
	rotation = Vector3()
	reparent.call_deferred(main_dummy, false)


func switch_camera_to(target_dummy: Node3D, on_camera_switched: Callable, duration: float = 1.0) -> void:
	var tween = create_tween()
	tween.tween_property(
		self,
		"global_transform",
		target_dummy.global_transform,
		duration
	).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(on_camera_switched)

func swtich_camera_to_default(on_camera_switched: Callable, duration: float = 1.0):
	switch_camera_to(main_dummy, on_camera_switched)

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
