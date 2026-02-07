extends Camera2D

# NOTE: Will want to make it so the camera only follows after a small window
#       of sustained holding left or right to not fuck it up during motion inputs
@export var x_offset_distance := 64
@export var y_offset_distance := -64
var target_pos :Vector2 

func _process(delta: float) -> void:
	target_pos.x = $"../Player".position.x + x_offset_distance * $"../Player".direction_facing
	target_pos.y = $"../Player".position.y + y_offset_distance
	position = position.lerp(target_pos, delta * 2)
