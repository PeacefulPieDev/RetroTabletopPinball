extends Node3D

class_name Route

func getCheckpointByIndex(index: int) -> Node3D:
	var checkpoints = $Checkpoints.get_children()
	return checkpoints[index]
