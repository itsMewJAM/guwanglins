extends CharacterBody2D

@export var player: Player

func _ready() -> void:
	if !player:
		player = %Player
		
func _process(delta: float) -> void:
	pass
