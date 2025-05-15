extends Node

@onready var end: Node2D = $".."
@onready var eye_animation: AnimatedSprite2D = $"../EyeAnimation"
@onready var end_label: Label = $"../EndLabel"
@onready var camera: Camera2D = $"../../Player/Camera2D"
@onready var end_music: AudioStreamPlayer = $"../EndMusic"
@onready var tears_audio_stream_player: AudioStreamPlayer2D = $"../../Salle oeil/Tears/TearsAudioStreamPlayer2D"

func end_game():
	eye_animation.modulate.a = 0
	end_label.modulate.a = 0
	
	var screen_size = get_viewport().size
	end.position = Vector2(camera.global_position.x - (screen_size.x/2),camera.global_position.y - (screen_size.y/2))
	
	end.visible = true
	end_music.play()
	
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	
	var tween2 = create_tween()
	tween2.tween_property(eye_animation, "modulate:a", 1.0, 3.0)
	
	var timer2 = get_tree().create_timer(3.0)
	await timer2.timeout
	
	eye_animation.play("cry")
		
	var timer3 = get_tree().create_timer(4.0)
	await timer3.timeout
	
	var tween3 = create_tween()
	tween3.tween_property(end_label, "modulate:a", 1.0, 2.0)
