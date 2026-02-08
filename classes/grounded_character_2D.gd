class_name GroundedCharacter2D
extends CharacterBody2D

# Should be usable for both player and enemy.

@export var speed_grounded := 100.0
@export var speed_airborne := 75.0
@export var jump_force := -200.0
@export var gravity := 400.0

var direction_trying := 0
var direction_jumping := 0
var trying_jump := false
var trying_attack := false
var jumping := false

func _physics_process(delta: float) -> void:
	#Falling
	velocity.y += gravity * delta
	
	#Try Grounded Movement
	#if is_on_floor():
		# Set jumping to false for returning to the ground
		#jumping = false
		
		# Update horizontal movement direction based on inputted direction
		#velocity.x = direction_trying * speed_grounded
		
		# Try Jump from ground
		#if trying_jump:
			#velocity.y = jump_force
			#direction_jumping = direction_trying
			#jumping = true # Will remain false if fallen from a ledge
	#else:
		#if jumping:
			#if velocity.y < 0: # Jump is rising
				#velocity.x = direction_jumping * speed_airborne
		#else:	
			#velocity.x = 0
	
	#Do Movement using velocity
	move_and_slide()
