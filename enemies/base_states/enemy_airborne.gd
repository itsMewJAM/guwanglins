extends State

class_name EnemyAirborne

func enter():
	enemy = state_machine.get_parent()
	enemy.anim.play("airborne")

func update(delta: float):
	pass