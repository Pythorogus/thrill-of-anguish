extends Node

@onready var eye_animation: AnimatedSprite2D = $"../EyeAnimation"
@onready var end_label: Label = $"../EndLabel"

func _ready():
	eye_animation.modulate.a = 0
	end_label.modulate.a = 0
	
	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	
	var tween2 = create_tween()
	tween2.tween_property(eye_animation, "modulate:a", 1.0, 2.0)
	
	var timer2 = get_tree().create_timer(2.0)
	await timer2.timeout
	
	eye_animation.play("cry")
		
	var timer3 = get_tree().create_timer(3.0)
	await timer3.timeout
	
	var tween3 = create_tween()
	tween3.tween_property(end_label, "modulate:a", 1.0, 2.0)
