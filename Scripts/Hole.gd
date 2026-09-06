@tool
extends Node3D

class_name Hole

signal hole_triggered(points: int)

@export var points: int = 0:
	set(value):
		points = value
		$StaticBody3D2/Label3D.text = str(points)

func _on_body_entered(body: Node3D) -> void:
	print("[Hole] Ball in the hole! points: " + str(points))
	emit_signal("hole_triggered", points)
