extends CharacterBody2D

var fleeing
@onready var detection_range: Area2D = $DetectionRange
@onready var despawn_timer: Timer = $DespawnTimer
@onready var exclamation: Sprite2D = $Sprite2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var normal1: AnimatedSprite2D = $Normal
@onready var golden1: AnimatedSprite2D = $Golden
@onready var cream1: AnimatedSprite2D = $Cream
@onready var orange1: AnimatedSprite2D = $Orange
@onready var shiny1: AnimatedSprite2D = $Shiny

var normal = false
var cream = false
var golden = false
var orange = false
var shiny = false
func _ready() -> void:
	normal1.visible = false
	var roll = randi() % 100 + 1  


	if roll == 5:
		golden = true 
		golden1.visible = true
	elif roll <= 40:
		normal = true
		normal1.visible = true
	elif roll <= 75:
		shiny = true
		shiny1.visible = true
	elif roll <= 80:
		orange = true 
		orange1.visible = true 
	else:
		cream = true
		cream1.visible = true




func _physics_process(delta: float) -> void:
	if fleeing == true:
		exclamation.visible = true
		normal1.play("flee")
		golden1.play("flee")
		cream1.play("flee")
		shiny1.play("flee")
		orange1.play("flee")
		velocity.y = -100
		velocity.x = 100
	
	move_and_slide()

func _on_detection_range_body_entered(body: CharacterBody2D) -> void:
	if body.name == "Player":
		flee()

func flee():
	particles.emitting = true
	despawn_timer.start()
	detection_range.monitoring = false
	fleeing = true

func _on_despawn_timer_timeout() -> void:
	queue_free()
