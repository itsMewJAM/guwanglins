extends GroundedCharacter2D

var direction_facing := 1 # This variable is kinda ugly theres gotta be a better way

func _process(delta: float) -> void:
	# Get movement direction from input
	direction_trying = Input.get_axis("player_left", "player_right")
	
	# PLACEHOLDER for camera movement
	if direction_trying != 0:
		direction_facing = direction_trying
	
	trying_jump = Input.is_action_pressed("player_jump")
	
