extends State

class_name PlayerJump

var player

func enter():
	player = state_machine.get_parent()
	player.anim.play("test")
