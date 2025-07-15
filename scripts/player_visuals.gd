extends Node2D

@export var player_controller : PlayerController
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var dust_particles: GPUParticles2D = $"../DustParticles"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_controller.velocity.x > 0:

		animation.play("walk")
	elif player_controller.velocity.x == 0:
		animation.play("idle")
	if player_controller.is_decelerating == true and player_controller.is_on_floor():
		animation.play("decel")
	
	if player_controller.velocity.y > 0:
		animation.play("slow_fall")
	elif player_controller.velocity.y > 20:
		animation.play("fall")
	elif player_controller.velocity.y < 0:
		animation.play("jump")

	if player_controller.damaged == true and player_controller.is_dead == false:
		animation.play("hit")
	elif player_controller.is_dead == true:
		animation.play("die")
	
	if player_controller.is_sliding == true:
		animation.play("slide")

	if player_controller.stunned == true:
		animation.play("stun")
