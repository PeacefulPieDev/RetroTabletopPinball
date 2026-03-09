extends RigidBody3D

#var shootDir = Vector3(3, 0, randi()%4-2   )
var shootDir = Vector3(-7, 0, 0 )

func _integrate_forces(state):	
	sleeping = false
	if Input.is_key_pressed(KEY_LEFT):
		state.apply_torque_impulse(Vector3(0, 1, 0 ))
		state.apply_force(Vector3(0, 1, 0 ))
	elif Input.is_key_pressed(KEY_RIGHT):
		state.apply_torque_impulse(Vector3(0, -1, 0 ))
		state.apply_force(Vector3(0, -1, 0 ))
