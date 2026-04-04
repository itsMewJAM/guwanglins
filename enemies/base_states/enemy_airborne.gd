extends State

class_name EnemyAirborne

var enemy

func enter():
	enemy = state_machine.get_parent()
	enemy.anim.play("airborne")
	# should be overridden after calling super() for enemies 
	# that are airborne by default
	enemy.change_dir_allowed = false

func update(delta: float):
	# TODO: Check if hit
	
	# Check if landed
	if enemy.is_on_floor() and enemy.velocity.y >= 0:
		state_machine.change_state("idle")

func physics_update(delta: float):
	pass
