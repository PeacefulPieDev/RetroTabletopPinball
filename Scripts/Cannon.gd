extends Node3D

class_name Cannon

@onready var trunk: Node3D = $HeroObjectGroup/gun/trunk
@onready var cannon: Node3D = $HeroObjectGroup/gun
@onready var ballposition: Node3D = $HeroObjectGroup/gun/trunk/BallPosition

func _ready() -> void:
	_on_v_slider_value_changed(50)
	_on_h_slider_value_changed(50)

func _on_v_slider_value_changed(value: float) -> void:
	var angle_deg = lerp(-90.0, -20.0, value / 100.0)
	trunk.rotation.y = deg_to_rad(angle_deg)


func _on_h_slider_value_changed(value: float) -> void:
	var angle_deg = lerp(20.0, -20.0, value / 100.0)
	cannon.rotation.z = deg_to_rad(angle_deg)


func _on_button_shoot_button_down() -> void:
	var ball = preload("res://Scenes/Ball.tscn").instantiate()
	ballposition.add_child(ball)
	ball.global_position = ballposition.global_position - ballposition.global_transform.basis.z * 2.0
	ball.apply_central_impulse(ballposition.global_transform.basis.z * 500.0)
