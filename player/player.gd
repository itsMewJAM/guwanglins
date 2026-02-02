extends GroundedCharacter2D

func _process(delta: float) -> void:
	# Get movement direction from input
	direction_trying = Input.get_axis("player_left", "player_right")
	
	trying_jump = Input.is_action_pressed("player_jump")
	
