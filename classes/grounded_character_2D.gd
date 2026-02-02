class_name GroundedCharacter2D
extends CharacterBody2D

# Should be usable for both player and enemy.

@export var speed_grounded := 100.0
@export var speed_airborne := 75.0
@export var jump_force := -200.0
@export var gravity := 400.0

var direction := 0
var trying_jump

func _physics_process(delta: float) -> void:
	#Falling
	velocity.y += gravity * delta
	
	#Try Grounded Movement
	if is_on_floor():
		#Update horizontal movement direction based on inputted direction
		velocity.x = direction * speed_grounded
		
		# Try Jump from ground
		if trying_jump:
			velocity.y = jump_force
			velocity.x = direction * speed_airborne
	
	#Do Movement using velocity
	move_and_slide()
