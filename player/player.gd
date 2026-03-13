extends CharacterBody2D

class_name Player

# Preloads & get nodes
const InputChecker = preload('res://player/attack_input_checks.gd')
@export var anim : AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var slash_sprite_front: Sprite2D = $SlashSpriteFront
@onready var slash_sprite_back: Sprite2D = $SlashSpriteBack
@onready var hurtbox: CollisionShape2D = $Hurtboxes/Hurtbox
@onready var hitbox: CollisionShape2D = $Hitboxes/Hitbox
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

# STATS
@export var speed_grounded := 100.0
@export var speed_airborne := 75.0
@export var jump_force := -200.0
@export var gravity := 400.0

@export var max_health : int
var health : int
var damage_allowed : bool = true

# INPUT VARS
enum Attack {NONE, ATTACK_5X, ATTACK_2X, ATTACK_236X, ATTACK_623X, ATTACK_22X}
var attack_input : Attack = Attack.NONE	# Attack motion performed
var input_registry = []				# Stores inputs for motion input detection
var direction_trying := 5			# Direction held (Numpad notation)
var trying_jump := false				# Jump button pressed

# CONDITION VARS	
var direction_facing := 1			# -1, 1
var direction_hurt := 0				# -1, 0, 1 (0 = not hurt)
var attack_stance : bool = false		# false = sheathed, true = unsheathed
var sheath_allowed : bool = true		# Condition is met to change to sheathed
var change_dir_allowed : bool = true # Condition is met to change direction


func _process(delta: float) -> void:
	# Get movement direction from input
	# direction_trying is based on numpad notation (where 6 is right and 4 is left) 
	direction_trying = 5 + Input.get_axis("player_left", "player_right") - 3*(Input.get_axis("player_up", "player_down"))
	trying_jump = Input.is_action_just_pressed("player_jump")
	attack_input = _handle_attack_input()
	if attack_input != Attack.NONE:
		print(attack_input)
	
	# Update facing direction
	if change_dir_allowed and Input.get_axis("player_left", "player_right") != 0:
		direction_facing = Input.get_axis("player_left", "player_right")
	if direction_facing < 0:
		rotation = PI
		scale.y = -1 
	else:
		rotation = 0
		scale.y = 1
	
	
	
func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta
	
	#Move using velocity
	move_and_slide()
	
func _handle_attack_input() -> Attack:
	var corrected_input = direction_trying
	# Invert horizontal inputs for the input reader if facing left
	if direction_facing < 0 and direction_trying % 3 == 1:
		corrected_input += 2
	if direction_facing < 0 and direction_trying % 3 == 0:
		corrected_input -= 2
	input_registry.push_front(corrected_input)
	if input_registry.size() > 30:
		input_registry.pop_back()

	# Start checking for which attack to do, but don't bother checking if the player hasn't inputted any attacks
	if !Input.is_action_just_pressed("player_attack"):
		return Attack.NONE
		
	#DEBUG: Display input registry any time you press attack
	print(input_registry)
	
	# Inputs that come first have higher priority
	if InputChecker.check_623X(input_registry) and !attack_stance:
	# change later when 623X is implemented
		return Attack.ATTACK_236X
	elif InputChecker.check_236X(input_registry) and !attack_stance:
		return Attack.ATTACK_236X
	# Uncomment when 2X and crouching are implemented
	# elif Input.is_action_pressed("player_down") and attack_stance:
	#	return Attack.ATTACK_2X
	elif InputChecker.check_22X(input_registry):
		return Attack.ATTACK_22X
	elif attack_stance:
		return Attack.ATTACK_5X
	return Attack.NONE

# Take damage function. Keep separate from hurt state in case we want something like drowning or fire damage that doesnt pop you up into the air.
func take_damage(amount: int = 1) -> void:
	health -= amount
	audio.play()
