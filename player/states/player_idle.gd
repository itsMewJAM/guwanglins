extends State

class_name PlayerIdle

var player

func enter():
	player = state_machine.get_parent()
	player.anim.play("idle")
	player.velocity.x = 0
	player.change_dir_allowed = true

func update(delta: float):
	# TODO: Check if hit
	
	if player.is_on_floor():
		if player.trying_jump:
			state_machine.change_state("jump")
		elif (player.attack_input == player.Attack.ATTACK_623X or 
			  player.attack_input == player.Attack.ATTACK_236X or 
			  player.attack_input == player.Attack.ATTACK_22X):
			state_machine.change_state("attack")
		elif 1 <= player.direction_trying and player.direction_trying <= 3:
			state_machine.change_state("crouch")
		elif player.direction_trying == 4 or player.direction_trying == 6:
			state_machine.change_state("run")
	else:
		state_machine.change_state("fall")
