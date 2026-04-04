extends State 

class_name EnemyIdle

var enemy 

func enter():
	enemy = state_machine.get_parent()
	enemy.anim.play("idle")
	enemy.velocity.x = 0
	enemy.change_dir_allowed = true

func update(delta: float):
	if enemy.is_on_floor():
		# May update with default behavior later. 
		pass 
	else:
		# Enemies that are airborne by default should override this to make sure this doesn't happen
		state_machine.change_state("fall");