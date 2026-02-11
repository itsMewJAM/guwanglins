extends CharacterBody2D

@export var player: Player
@onready var eye_sprite: Sprite2D = $EyeSprite

func _ready() -> void:
	if !player:
		player = %Player
		
func _process(delta: float) -> void:
	eye_sprite.global_position = global_position.move_toward(player.position, 4)
