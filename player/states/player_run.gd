extends State

class_name PlayerRun

var player

func enter():
	player = state_machine.get_parent()
	# player.anim.play("run") TODO: create animation
	
func update(delta: float):
	# TODO: Check if hit
	
	if player.is_on_floor:
		if player.trying_jump:
			state_machine.change_state("jump")
		elif player.attack == player.Attack.ATTACK_5X:
			state_machine.change_state("attack5x")
		elif player.attack == player.Attack.ATTACK_2X:
			state_machine.change_state("attack2x")
		elif player.attack == player.Attack.ATTACK_236X:
			state_machine.change_state("attack236x")
		elif player.attack == player.Attack.ATTACK_623X:
			state_machine.change_state("attack5x")
		elif player.attack == player.Attack.ATTACK_22X:
			state_machine.change_state("attack22x")
		elif 1 >= player.direction_trying and player.direction_trying >= 3:
			state_machine.change_state("crouch")
		elif player.direction_trying == 5:
			state_machine.change_state("idle")
	else:
		state_machine.change_state("fall")


func physics_update(delta: float):
	player.velocity.x = (player.direction_trying - 5) * player.speed_grounded
