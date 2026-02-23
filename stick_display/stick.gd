extends Node2D

@export var ball_sprite: Sprite2D
@export var stick_distance: int

func _process(delta) -> void:
	var x_input = Input.get_axis("player_left", "player_right")
	var y_input = Input.get_axis("player_up", "player_down")
	var input = Vector2(x_input, y_input).normalized()
	input *= stick_distance
	
	ball_sprite.position = input
	
