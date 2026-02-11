extends State

class_name PlayerHurt

var player

func enter():
	player = state_machine.get_parent()
	player.anim.play("hurt")
	player.take_damage()
	player.change_dir_allowed = false
	player.velocity.y = player.jump_force

func update(delta: float):
	# Check if landed
	if player.is_on_floor() and player.velocity.y >= 0:
		# Replace with recovery state later
		state_machine.change_state("idle")

func physics_update(delta: float):
	if player.velocity.y < 0: # Jump is rising
			player.velocity.x = player.direction_hurt * player.speed_airborne
			
func exit():
	player.direction_hurt = 0
	player.sprite.visible = true		
	player.hurtbox.disabled = false
