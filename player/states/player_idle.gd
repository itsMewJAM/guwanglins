extends State

class_name PlayerIdle

var player

func enter():
	player = state_machine.get_parent()
	print(player)
	#player.anim.play("idle")

func physics_update(delta: float):
	if player.trying_attack:
		state_machine.change_state("jump")
