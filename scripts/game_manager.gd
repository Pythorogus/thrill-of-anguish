extends Node

@onready var fade_in: ColorRect = $"../Player/Camera2D/FadeIn"
@onready var camera: Camera2D = $"../Player/Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_colorrect_size()
	var tween = create_tween()
	tween.tween_property(fade_in, "modulate:a", 0.0, 1.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_colorrect_size()

func update_colorrect_size()->void:
	# Récupérer la taille de la fenêtre de jeu (viewport)
	var screen_size = get_viewport().size
	fade_in.custom_minimum_size = screen_size
	fade_in.position = camera.position
