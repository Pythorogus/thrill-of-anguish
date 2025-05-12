extends Node

@onready var fade_in: ColorRect = $"../FadeIn"
@onready var camera: Camera2D = $"../Player/Camera2D"
@onready var player: CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_control = false
	update_colorrect_size()
	var tween = create_tween()
	tween.tween_property(fade_in, "modulate:a", 0.0, 2.0)
	var timer = get_tree().create_timer(2.0)  # 3 secondes de délai avant de commencer le fade-in
	await timer.timeout
	player.can_control = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_colorrect_size()

func update_colorrect_size()->void:
	# Récupérer la taille de la fenêtre de jeu (viewport)
	var screen_size = get_viewport().size
	fade_in.custom_minimum_size = screen_size
	fade_in.position = camera.position
