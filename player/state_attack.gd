class_name State_Attack extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5.0

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_effect_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

@onready var walk: State = $"../Walk"
@onready var idle: State = $"../Idle"
@onready var hurt_box: HurtBox = %AttackHurtBox

# What happens when player enters this state.
func enter() -> void:

  # Animation
  self.player.update_animation("attack")
  self.attack_effect_animation.play("attack_%s" % player.animation_direction())
  self.animation_player.animation_finished.connect(self.end_attack)

  #Audio
  self.audio.stream = attack_sound
  self.audio.pitch_scale = randf_range(0.90, 1.1)
  self.audio.play()

  self.attacking = true

  # Delay for partial animation
  var wait_time = attack_effect_animation.current_animation_length / 4
  await self.get_tree().create_timer(wait_time).timeout
  self.hurt_box.monitoring = true

  pass

# What happens when player exits this state.
func exit() -> void:
  self.animation_player.animation_finished.disconnect(self.end_attack)
  self.attacking = false
  self.hurt_box.monitoring = false
  pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
  self.player.velocity -= player.velocity * decelerate_speed * _delta

  if !self.attacking:
    if self.player.direction == Vector2.ZERO:
      return self.idle
    else:
      return self.walk
  return null

# What happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
  return null

# What happens with input events in this state?
func handle_input(_event: InputEvent) -> State:
  return null

func end_attack(_newAnimationName: String) -> void:
  self.attacking = false
