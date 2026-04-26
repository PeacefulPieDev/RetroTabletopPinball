@tool

extends Node3D

class_name Checkpoint

enum type_enum { DEFAULT, BIG, BLUE }

@export var index: int = 0:
	set(value):
		index = value
		$Label3D.text = str(index)
		
@export var type: type_enum = type_enum.DEFAULT:
	set(value):
		type = value
		set_type(type)

func _enter_tree():
	$Label3D.text = str(index)

func set_type(type: type_enum):
	$MeshInstance3D.hide()
	$MeshInstance3D2.hide()
	$MeshInstance3D3.hide()
	if type == type_enum.DEFAULT:
		$MeshInstance3D.show()
	elif type == type_enum.BIG:
		$MeshInstance3D2.show()	
	elif type == type_enum.BLUE:
		$MeshInstance3D3.show()
		
			
	
