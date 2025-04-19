extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

var is_on_ground = false
var coyote_time = 0.2 # en secondes
var coyote_timer = 0.0

var is_attacking = false
var can_control = true
var can_hit = false
var hit_sound_played = false
var last_checkpoint : Vector2 = Vector2(289,727)
var last_checkpoint_position_y_water : int

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var heart: Node2D = $"../Heart"
@onready var death_timer: Timer = $DeathTimer

@onready var water: Node2D = $"../Water"
@onready var platform3: AnimationPlayer = $"../Platform3/AnimationPlayer"
@onready var platform4: AnimationPlayer = $"../Platform4/AnimationPlayer"
@onready var enemy1: Node2D = $"../Enemies/Enemy"
@onready var enemy2: Node2D = $"../Enemies/Enemy2"
@onready var enemy3: Node2D = $"../Enemies/Enemy3"
@onready var enemy4: Node2D = $"../Enemies/Enemy4"
@onready var enemy5: Node2D = $"../Enemies/Enemy5"


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_on_ground = false
		coyote_timer -= delta
	else:
		is_on_ground = true
		coyote_timer = coyote_time

	if can_control:
		# Handle jump
		if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_timer > 0.0):
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0.0
			#jump_sound.play()

			# Get the input direction: -1, 0, 1
		var direction := Input.get_axis("move_left", "move_right")
		
		# Flip the Sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
			
		# Play animations
		if is_on_floor():
			if Input.is_action_just_pressed("hit") and not is_attacking and can_hit:
				print("hit")
				is_attacking = true
				can_control = false
				animated_sprite.play("hit")
			elif not is_attacking:
				if direction == 0:
					animated_sprite.play("idle")
				else:
					animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
			
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
		
	else:
		# Si pas de contrôle, ralentit doucement
		velocity.x = move_toward(velocity.x, 0, SPEED)

func die():
	can_control = false
	is_attacking = false
	death_sound.play()
	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0, 0), 0.2)
	tween.tween_callback(Callable(self, "_on_death_finished"))
	death_timer.start()
	
func _on_death_timer_timeout() -> void:
	# Reset de water en fonction du checkpoint
	water.moveTo(last_checkpoint_position_y_water)
	
	#Reset des plateforms
	platform3.stop(true)
	platform3.play()
	platform4.stop(true)
	platform4.play()
	
	#Reset des ennemis
	enemy1.position.x = 2791
	enemy2.position.x = 2856
	enemy3.position.x = 3140
	enemy4.position.x = 2482
	enemy5.position.x = 584
	
	#Reset du joueur
	position = last_checkpoint
	var tween = create_tween()
	tween.tween_property(animated_sprite, "modulate", Color(1, 0, 0, 1), 0.2)
	can_control = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hit":
		can_hit = false
		is_attacking = false
		animated_sprite.play("idle")

# Hit the heart
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite.animation == "hit" and animated_sprite.frame == 1 and not hit_sound_played:
		hit_sound.play()
		can_control = false
		heart.anguish()
