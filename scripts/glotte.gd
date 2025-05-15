extends Node2D

var swing_speed = 2.0      # fréquence de l'oscillation
var swing_angle = 20.0     # angle max en degrés
var time_passed = 0.0

var oscillation_height = 20.0
var oscillation_duration = 2.0

func _physics_process(delta):
	time_passed += delta
	rotation_degrees = sin(time_passed * swing_speed) * swing_angle

func reset_position():
	time_passed = 2.0 # pour que le joueur puisse passer au reset
