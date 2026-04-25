extends RigidBody3D

#var shootDir = Vector3(3, 0, randi()%4-2   )
var shootDir = Vector3(-1, 0, 0 )

func _integrate_forces(state):	
	sleeping = false
	if Input.is_key_pressed(KEY_SPACE):
		state.apply_central_impulse(shootDir)		
 
