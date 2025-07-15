extends Node2D

@onready var buttons: AnimatedSprite2D = $Buttons
@onready var play_button: Area2D = $Buttons/PlayButton
@onready var exit_button: Area2D = $Buttons/ExitButton
var play = false
var exit = false
func _ready() -> void:
	play_button.monitoring = false
	exit_button.monitoring = false
	buttons.play("intro")

func _process(delta: float) -> void:
	if buttons.animation_finished:
		play_button.monitoring = true
		exit_button.monitoring = true
	if Input.is_action_just_pressed("click") and exit == true:
		await get_tree().create_timer(0.1).timeout
		get_tree().quit()
	if Input.is_action_just_pressed("click") and play == true:
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file("res://scenes/testing.tscn")
		
func _on_play_button_mouse_entered() -> void:
	play = true
	buttons.play("play")
func _on_play_button_mouse_exited() -> void:
	play = false
	buttons.play("normal")

func _on_exit_button_mouse_entered() -> void:
	exit = true
	buttons.play("exit")


func _on_exit_button_mouse_exited() -> void:
	exit = false
	buttons.play("normal")


func _on_play_screen_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file("res://scenes/testing.tscn")


func _on_exit_screen_button_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
