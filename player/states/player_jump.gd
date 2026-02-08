extends State

class_name PlayerJump

var player
var direction_jumping

func enter():
	player = state_machine.get_parent()
	# player.anim.play("jump")  TODO: create animation
	player.velocity.y = player.jump_force
	
	# Numpad to L/R (-1, 0, 1) direction conversion
	direction_jumping = (player.direction_trying + 2) % 3 - 1

func update(delta: float):
	# TODO: Check if hit
	
	# Check if landed
	if player.is_on_floor() and player.velocity.y >= 0:
		# Replace with recovery state later
		state_machine.change_state("idle")

func physics_update(delta: float):
	if player.velocity.y < 0: # Jump is rising
			player.velocity.x = direction_jumping * player.speed_airborne
