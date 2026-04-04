extends State

class_name EnemyFall

var enemy

func enter():
	enemy = state_machine.get_parent()
	enemy.anim.play("fall") 
	enemy.change_dir_allowed = false
	enemy.velocity.x = 0

func update(delta: float):
	# TODO: Check if hit
	
	# Check if landed
		if enemy.is_on_floor():
			# Replace with recovery state later
			state_machine.change_state("idle")