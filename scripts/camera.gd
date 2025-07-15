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
	



func _on_move_pressed() -> void:
	if player.direction == 0:
		player.direction = 1
	elif player.direction == 1:
		player.direction = 0


func _on_jump_pressed() -> void:
	player.jump()


func _on_slide_pressed() -> void:
	player.is_sliding = true
