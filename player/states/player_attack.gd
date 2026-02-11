extends State

class_name PlayerAttack

var player
# Don't modify this outside of the enter() call or I will smite you.
# GDScript is cringe and won't allow me to make this a const since a dict is mutable. Joy.
var _attack_anim_dict

# Assumes it's being given a good input by the input checker and state transition.
# (maybe) TODO: Add check for invalid input combinations (ie: ATTACK_236X while attack_stance = true)
# The safer code is less elegant though
func _handle_attack_anim():
	if player.attack_input == player.Attack.ATTACK_22X:
		if player.attack_stance:
			player.attack_stance = false
			player.anim.play("attack_22x_sheathe")
		else:
			player.attack_stance = true
			player.anim.play("attack_22x_unsheathe")
	else:
		player.attack_stance = true
		player.anim.play(_attack_anim_dict[player.attack_input])

func enter():
	player = state_machine.get_parent()
	_attack_anim_dict = {
		player.Attack.ATTACK_5X: 'attack_5x',
		player.Attack.ATTACK_236X: 'attack_236x',
		player.Attack.ATTACK_22X: 'attack_22x',
	}
	player.anim.play("crouch")
	player.velocity.x = 0
	player.change_dir_allowed = false

	_handle_attack_anim()

func update(delta: float):
	# TODO: Check if hit
	
	if player.is_on_floor():
		# only enter idle once animation has completed
		pass
	else:
		state_machine.change_state("fall")
