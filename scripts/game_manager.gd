extends Node

@onready var fade_in: ColorRect = $"../FadeIn"
@onready var camera: Camera2D = $"../Player/Camera2D"
@onready var player: CharacterBody2D = $"../Player"
@onready var tears_audio_stream_player_2d: AudioStreamPlayer2D = $"../Salle oeil/Tears/TearsAudioStreamPlayer2D"
@onready var whoosh: AudioStreamPlayer = $"../Whoosh"
@onready var enemy5: Node2D = $"../Enemies/Enemy5"

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
	fade_in.position = Vector2(camera.global_position.x - (screen_size.x/2),camera.global_position.y - (screen_size.y/2))
	
func _on_end_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		enemy5.move = false
		player.can_control = false
		update_colorrect_size()
		whoosh.play()
		fade_in.color = Color('#FFF')
		enemy5.move = false
		
		var tween = create_tween()
		tween.tween_property(fade_in, "modulate:a", 1.0, 2.0)
		
		var tween2 = create_tween()
		tween.tween_property(tears_audio_stream_player_2d, "volume_db", 0.0, 2.0)
		
		var timer = get_tree().create_timer(4.0)
		await timer.timeout
		
		ProjectSettings.set_setting("rendering/environment/defaults/default_clear_color","FFF")
		#ProjectSettings.save()
		
		get_tree().change_scene_to_file("res://scenes/end.tscn")
