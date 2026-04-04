extends CharacterBody2D

class_name Enemy

@export var anim: AnimationPlayer 
@export var player: Player 
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: CollisionShape2D = $Hurtboxes/Hurtbox
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

# STATS
@export var gravity := 400.0
# Child classes should override these
@export var speed_grounded := 0
@export var speed_airborne := 0
@export var jump_force := -200

@export var max_health : int
var health : int
var damage_allowed : bool = true

# CONDITION VARS	
var direction_facing := 1			# -1, 1
var direction_hurt := 0				# -1, 0, 1 (0 = not hurt)

# Abstract class without enforcement 
# The intention is to never create an instance of a base enemy class,
# but to make child classes of the Enemy class and create instances of those.
# Every child class is guaranteed the minimum behavior outlined by the Enemy superclass

# Abstract class enforcement was added in Godot 4.5 but we're still on 4.4 teehee

func _process(delta: float) -> void:
	_physics_process(delta)

# Identical to Player
func _physics_process(delta: float) -> void:
	# Apply gravity
	velocity.y += gravity * delta
	
	#Move using velocity
	move_and_slide()

# Identical to Player
func take_damage(amount: int = 1) -> void:
	health -= amount
	audio.play()

# Base Method for Enemy AI. Abstract in principle, so it does nothing.
func make_decisions():
	pass 
