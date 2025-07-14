extends Camera2D

@export var player: CharacterBody2D
@onready var sprite: AnimatedSprite2D = $CanvasLayer/AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer
var last_health = -1

func _process(delta: float) -> void:
	if player.health != last_health:
		match player.health:
			3:
				sprite.play("3")
			2:
				sprite.play("2")
			1:
				sprite.play("1")
			_:
				player.die(1.5, 300)
				animation_player.play("close")
				sprite.play("0")
		last_health = player.health

	position.x = player.position.x + 140
