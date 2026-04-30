@tool

extends Node3D

class_name Checkpoint

enum type_enum { DEFAULT, BIG, BLUE, SMALL }

@export var index: int = 0:
	set(value):
		index = value
		$Label3D.text = str(index)

@export var type: type_enum = type_enum.DEFAULT:
	set(value):
		type = value
		update_type()

@export_group("Special")
@export var skip_turn: bool = false
@export var secondary_route: Route
@export var jump_checkpoint: Checkpoint
@export var exit_checkpoint: Checkpoint

func _enter_tree():
	$Label3D.text = str(index)

func update_type():
	$MeshInstance3D.hide()
	$MeshInstance3D2.hide()
	$MeshInstance3D3.hide()
	$MeshInstance3D4.hide()
	if type == type_enum.DEFAULT:
		$MeshInstance3D.show()
	elif type == type_enum.BIG:
		$MeshInstance3D2.show()
	elif type == type_enum.BLUE:
		$MeshInstance3D3.show()
	elif type == type_enum.SMALL:
		$MeshInstance3D4.show()
		$Label3D.hide()
