extends Node

@onready var title_label: Label = $"../TitleLabel"
@onready var press_enter_label: Label = $"../PressEnterLabel"
@onready var title_screen_music: AudioStreamPlayer = $"../TitleScreenMusic"
@onready var enter_sfx: AudioStreamPlayer = $"../EnterSFX"
@onready var fade_out: ColorRect = $"../FadeOut"

var canPressEnter = false

func _ready():
	# Démarre invisible
	fade_out.modulate.a = 0.0
	title_label.modulate.a = 0.0  
	press_enter_label.modulate.a = 0.0

	var timer = get_tree().create_timer(2.0)  # 3 secondes de délai avant de commencer le fade-in
	await timer.timeout

	var tween = create_tween()
	tween.tween_property(title_label, "modulate:a", 1.0, 1.0)  # Vers alpha = 1 sur 1 seconde

	var timer2 = get_tree().create_timer(2.0)  # 3 secondes de délai avant de commencer le fade-in
	await timer2.timeout

	canPressEnter = true
	pressEnterAnimation()

func pressEnterAnimation():
	var tween = create_tween()
	tween.tween_property(press_enter_label, "modulate:a", 1.0, 1.0)
	tween.tween_property(press_enter_label, "modulate:a", 0.0, 1.0)
	tween.finished.connect(func(): pressEnterAnimation())
	
func _process(_delta: float)->void:
	if canPressEnter and Input.is_action_just_pressed("enter"):
		canPressEnter = false
		enter_sfx.play()
		var tween = create_tween()
		tween.tween_property(title_screen_music, "volume_db", -80, 2.0)
		var timer = get_tree().create_timer(1.0)
		await timer.timeout
		
		var tween2 = create_tween()
		tween2.tween_property(fade_out, "modulate:a", 1.0, 2.0)
		var timer2 = get_tree().create_timer(3.0)
		await timer2.timeout
		
		get_tree().change_scene_to_file("res://scenes/game.tscn")
