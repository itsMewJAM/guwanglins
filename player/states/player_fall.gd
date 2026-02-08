extends State

class_name PlayerFall

var player

func enter():
	player = state_machine.get_parent()
	# player.anim.play("fall") TODO: create animation
	player.change_dir_allowed = false
	player.velocity.x = 0

func update(delta: float):
	# TODO: Check if hit
	
	# Check if landed
		if player.is_on_floor():
			# Replace with recovery state later
			state_machine.change_state("idle")
