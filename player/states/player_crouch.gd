extends State

class_name PlayerCrouch

var player

func enter():
	player = state_machine.get_parent()
	player.anim.play("crouch")
	player.velocity.x = 0
	player.change_dir_allowed = false 

func update(delta: float):
	# TODO: Check if hit
	
	if player.is_on_floor():
		if player.trying_jump:
			state_machine.change_state("jump")
		elif player.attack_input != player.Attack.NONE:
			state_machine.change_state("attack")
		elif player.direction_trying == 5:
			state_machine.change_state("idle")
		elif player.direction_trying == 4 or player.direction_trying == 6:
			state_machine.change_state("run")
	else:
		state_machine.change_state("fall")
