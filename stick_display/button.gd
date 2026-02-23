extends Node2D

@export var button_sprite: Sprite2D
@export var input_name: String
@export var button_index: int

func _process(delta) -> void:
	if Input.is_action_pressed(input_name):
		button_sprite.frame_coords = Vector2i(button_index, 1)
	else:
		button_sprite.frame_coords = Vector2i(button_index, 0)
