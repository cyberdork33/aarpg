class_name State_Attack extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_effect_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"

# What happens when player enters this state.
func Enter() -> void:
	
	# Animation
	player.update_animation("attack")
	attack_effect_animation.play("attack_%s" % player.animation_direction())
	animation_player.animation_finished.connect(EndAttack)
	
	#Audio
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.90, 1.1)
	audio.play()
	
	attacking = true
	pass

# What happens when player exits this state.
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass

# What happens during the _process update in this state?
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if !attacking:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

# What happens during the _physics_process update in this state?
func Physics(_delta: float) -> State:
	return null
	
# What happens with input events in this state?
func HandleInput(_event: InputEvent) -> State:
	return null
	
func EndAttack(_newAnimationName: String) -> void:
	attacking = false
