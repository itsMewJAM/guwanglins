extends State 

class_name EnemyIdle

var enemy 

func enter():
	enemy = state_machine.get_parent()
	enemy.anim.play("idle")

func update(delta: float):
	pass