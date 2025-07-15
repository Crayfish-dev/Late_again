extends CharacterBody2D

@export var speed = 100
@export var deceleration = 200
@onready var wheel: Sprite2D = $wheel
@onready var wheel_2: Sprite2D = $wheel2

var start = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const WHEEL_RADIUS := 4.5

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y = 100

	if start:
		velocity.x = -speed
	else:
		if velocity.x < 0:
			velocity.x = min(velocity.x + deceleration * delta, 0)

	var dx = velocity.x * delta
	var angle_radians = dx / WHEEL_RADIUS
	wheel.rotation += angle_radians
	wheel_2.rotation += angle_radians

	move_and_slide()

func _on_player_detector_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		start = true

func _on_player_detector_body_exited(body: CharacterBody2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(10).timeout
		queue_free()

func _on_hit_detector_body_entered(body: CharacterBody2D) -> void:
	sprite.play("hit")

func _on_decelleration_detector_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		start = false
