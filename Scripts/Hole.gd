@tool
extends Node3D

class_name Hole

@export var bonus: int = 0:
	set(value):
		bonus = value
		$StaticBody3D2/Label3D.text = str(bonus)

func _on_body_entered(body: Node3D) -> void:
	if body.name == "RigidBody3D_Ball":
		print("Ball in the hole!")
