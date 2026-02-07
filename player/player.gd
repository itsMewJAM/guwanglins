extends GroundedCharacter2D

enum Attack {NONE, ATTACK_5X, ATTACK_2X, ATTACK_236X, ATTACK_623X, ATTACK_22X}

const InputChecker = preload('res://player/attack_input_checks.gd')
@onready var _animated_sprite = $AnimatedSprite2D

var direction_facing := 1 # This variable is kinda ugly theres gotta be a better way
var input_registry = []
var attack_stance = false

func _ready() -> void:
	_animated_sprite.play('idle')

func _process(delta: float) -> void:
	# Get movement direction from input
	direction_trying = Input.get_axis("player_left", "player_right")
	
	# PLACEHOLDER for camera movement
	if direction_trying != 0:
		direction_facing = direction_trying
	
	trying_jump = Input.is_action_pressed("player_jump")
	
	_handle_attack(_handle_attack_input())
	_handle_animation()

func _handle_animation() -> void:
	pass
	
func _handle_attack_input() -> Attack:
	# Maps the player input to the numpad notation of inputs
	var input_8way = 5 + Input.get_axis("player_left", "player_right") - 3*(Input.get_axis("player_up", "player_down"))
	input_registry.push_front(input_8way)
	if input_registry.size() > 30:
		input_registry.pop_back()

	# Start checking for which attack to do, but don't bother checking if the player hasn't inputted any attacks
	if !Input.is_action_just_pressed("player_attack"):
		return Attack.NONE
	# Inputs that come first have higher priority
	# Uncomment when 623X is implemented
	print(input_registry)
	if InputChecker.check_623X(input_registry) and !attack_stance:
	# change later
		print('623x')
		return Attack.ATTACK_236X
	elif InputChecker.check_236X(input_registry) and !attack_stance:
		print('236x')
		return Attack.ATTACK_236X
	# Uncomment when 2X and crouching are implemented
	# elif Input.is_action_pressed("player_down") and attack_stance:
	#	return Attack.ATTACK_2X
	elif InputChecker.check_22X(input_registry):
		print('22x')
		return Attack.ATTACK_22X
	elif attack_stance:
		print('5x')
		return Attack.ATTACK_5X
	return Attack.NONE 

func _handle_attack(attack: Attack) -> void:
	match attack:
		Attack.ATTACK_5X:
			print('5x')
			_animated_sprite.play("attack")
		Attack.ATTACK_236X:
			attack_stance = true
			_animated_sprite.play("236x")
		Attack.ATTACK_22X:
			if attack_stance:
				attack_stance = false
				_animated_sprite.play("sheathe")
			else:
				attack_stance = true
				_animated_sprite.play("unsheathe")
		
