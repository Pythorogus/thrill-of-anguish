extends Node2D

var swing_speed = 2.0      # fréquence de l'oscillation
var swing_angle = 20.0     # angle max en degrés
var time_passed = 0.0

var oscillation_height = 20.0
var oscillation_duration = 2.0

func _ready():
	pass
	#var original_y = position.y
	#var tween = create_tween()
	#tween.set_loops()  # boucle infiniment
	#tween.tween_property(self, "position:y", original_y - oscillation_height, oscillation_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self, "position:y", original_y + oscillation_height, oscillation_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func _physics_process(delta):
	time_passed += delta
	rotation_degrees = sin(time_passed * swing_speed) * swing_angle
	##position.y += 1
