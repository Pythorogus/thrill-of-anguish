extends Node2D

var swing_speed = 2.0      # fréquence de l'oscillation
var swing_angle = 20.0     # angle max en degrés
var time_passed = 0.0

func _physics_process(delta):
	time_passed += delta
	rotation_degrees = sin(time_passed * swing_speed) * swing_angle
