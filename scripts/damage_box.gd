extends Area2D

@export var damage = 1

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		body.take_damage(damage, 300, 0.5)
