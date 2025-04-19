extends Node2D

@onready var heartbeat: AudioStreamPlayer2D = $Heartbeat
@onready var metal: AudioStreamPlayer2D = $Metal

@onready var sprite: Sprite2D = $Sprite2D
@onready var timer_after_hit: Timer = $TimerAfterHit
@onready var key_hit: Label = $"../KeyText/KeyHit"
@onready var key_jump: Label = $"../KeyText/KeyJump"
@onready var key_move: Label = $"../KeyText/KeyMove"

@onready var run_back: Label = $"../KeyText/RunBack"
@onready var player: CharacterBody2D = $"../Player"
@onready var heartzone: Area2D = $Heartzone
@onready var tears: AnimatedSprite2D = $"../Salle oeil/Tears"
@onready var enemy: Node2D = $"../Enemies/Enemy"
@onready var enemy2: Node2D = $"../Enemies/Enemy2"
@onready var enemy3: Node2D = $"../Enemies/Enemy3"
@onready var enemy4: Node2D = $"../Enemies/Enemy4"
@onready var enemy5: Node2D = $"../Enemies/Enemy5"
@onready var end_zone: Area2D = $"../EndZone"
@onready var water: Node2D = $"../Water"
@onready var water_trigger: Area2D = $"../WaterTrigger"

var timer = 0.0
var interval = 1 
var player_z_index = 0
var beaten = false

func _process(delta: float) -> void:
	timer += delta
	if timer >= interval:
		var tween = create_tween()
		timer = 0
		heartbeat.play()
		tween.tween_property(sprite, "scale", Vector2(1.05, 1.05), 0.1)
		tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.1)

func _on_heartzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.can_hit = true

func _on_heartzone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.can_hit = false

# ON HIT
func anguish()-> void:
	interval = -1
	timer_after_hit.start()
	key_hit.visible = false

# AFTER HIT
func _on_timer_after_hit_timeout() -> void:
	beaten = true
	interval = 0.2
	metal.play()
	
	heartzone.monitoring = false
	player.can_control = true
	tears.visible = true
	
	# Texts
	run_back.visible = true
	key_jump.visible = false
	key_move.visible = false
	
	# Enemies
	enemy.visible = true;
	enemy.process_mode = Node.PROCESS_MODE_INHERIT
	enemy2.visible = true;
	enemy2.process_mode = Node.PROCESS_MODE_INHERIT
	enemy3.visible = true;
	enemy3.process_mode = Node.PROCESS_MODE_INHERIT
	enemy4.visible = true;
	enemy4.process_mode = Node.PROCESS_MODE_INHERIT
	enemy5.visible = true;
	enemy5.process_mode = Node.PROCESS_MODE_INHERIT
	
	# End zone
	end_zone.process_mode = Node.PROCESS_MODE_INHERIT
	
	# Water trigger
	water_trigger.process_mode = Node.PROCESS_MODE_INHERIT
