extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.name == "RigidBody3D_Ball":
		print("Ball in the hole!")
	pass # Replace with function body.
