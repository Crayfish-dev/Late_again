extends CharacterBody2D
class_name PlayerController

@onready var shape: CollisionShape2D = $CollisionShape2D
@export var can_move = true
@export var is_dead = false
@export var max_speed = 300.0
@export var acceleration = 1000.0
@export var deceleration = 400.0
@export var jump_power = 10.0
@onready var death_timer: Timer = $DeathTimer
@onready var damage_timer: Timer = $DamageTimer
@onready var slide_shape: CollisionShape2D = $Slide_shape
@onready var slide_timer: Timer = $SlideTimer
@onready var sprite: AnimatedSprite2D = $PlayerVisuals/AnimatedSprite2D
var stunned = false

var damaged = false
var jump_multiplier = -30.0
var direction = 0.0
var is_decelerating := false
var health = 3
var is_sliding = false

func _physics_process(delta: float) -> void:
	if can_move == false:
		velocity.x = 0
		velocity.y = 0
		direction = 0
		is_sliding = false
	
	if health < 0:
		health = 0
	
	if is_dead == true:
		velocity.x = 0
		direction = 0
		
	if Input.is_action_just_pressed("debug_stop"):
		get_tree().paused = true

	if damaged == true:
		direction = 0
	if health == 0:
		health = -1
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Read movement input
	if Input.is_action_pressed("move"):
		direction = 1.0
	elif Input.is_action_pressed("stop"):
		stop()
	
	# Calculate horizontal velocity
	var target_speed = direction * max_speed

	if direction != 0:
		# Accelerate
		velocity.x = move_toward(velocity.x, target_speed, acceleration * delta)
		is_decelerating = false
	else:
		# Decelerate
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		is_decelerating = abs(velocity.x) > 0.1

	if Input.is_action_just_pressed("slide") and is_on_floor() and is_sliding == false:
		is_sliding = true
		slide_timer.start()
	
	if is_sliding:
		velocity.x = max_speed * 1.3
		slide_shape.disabled = false
		shape.disabled = true
	elif is_sliding == false and is_dead == false:
		shape.disabled = false
		slide_shape.disabled = true
	
	move_and_slide()
	
	
func _input(event):
	# Handle jump
	if event.is_action_pressed("jump") and is_on_floor():
		jump()

func take_damage(damage, knokback, time):
	is_sliding = false
	damage_timer.wait_time = time
	damage_timer.start()
	damaged = true
	direction = 0
	if health > 0:
		health -= damage
	velocity.x = -knokback
	
func stun(knokback, dir, time):
	stunned = true
	velocity.x = -knokback
	direction = dir
	await get_tree().create_timer(0.4).timeout
	can_move = false
	stunned = false
	await get_tree().create_timer(time).timeout
	can_move = true
	direction = 1


func die(time, jump):
	is_dead = true
	stop()
	velocity.x = 0
	velocity.y = -jump
	shape.disabled = true
	death_timer.wait_time = time
	death_timer.start()


func stop():
	direction = 0
func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()


func _on_damage_timer_timeout() -> void:
	direction = 1
	damaged = false


func _on_slide_timer_timeout() -> void:
	is_sliding = false

func jump():
	while is_sliding:
		velocity.x = 1.6 * max_speed * direction
		velocity.y = jump_power * jump_multiplier
		is_sliding = false
	velocity.y = jump_power * jump_multiplier
