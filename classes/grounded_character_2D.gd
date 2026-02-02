class_name GroundedCharacter2D
extends CharacterBody2D

# Should be usable for both player and enemy.

@export var speed := 100.0
@export var jump_force := 100.0
@export var gravity := 400.0

var direction := 0
var trying_jump := false

func _physics_process(delta: float) -> void:
	#Horizontal Movement
	velocity.x = direction * speed
	
	#Falling
	velocity.y += gravity * delta
	
	#Attempt Jump
	if trying_jump and is_on_floor():
		velocity.y = jump_force
	
	#Do Movement using velocity
	move_and_slide()
