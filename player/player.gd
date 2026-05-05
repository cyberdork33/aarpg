class_name Player extends CharacterBody2D

signal direction_changed(direction: Vector2)
signal player_damaged(hurt_box: HurtBox)

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

var invulnerable: bool = false
var hit_points: int = 6
var max_hit_points = 6
const FULL_HEALTH = 99

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var hit_box: HitBox = $HitBox
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  PlayerManager.player = self
  self.state_machine.initialize(self)
  self.hit_box.damaged.connect(_take_damage)
  self.update_hit_points(FULL_HEALTH)
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

  # Retrieve direction input
  # Separate Input Map actions for DPad and Joysticks. Putting both
  # on one action means that when you use get_vector(), you read the dpad input
  # as well as the noise on the joysticks as the same time. This leads to capturing
  # non cardinal directions when only using DPad.
  self.direction = Input.get_vector("left", "right", "up", "down")
  if self.direction == Vector2.ZERO: # Only attempt to get joystick input when no other direction data is obtained.
    self.direction = Input.get_vector("joy_left", "joy_right", "joy_up", "joy_down")

  pass


func _physics_process(_delta: float) -> void:
  self.move_and_slide()

func set_direction() -> bool:
  var new_direction: Vector2 = cardinal_direction

  if self.direction == Vector2.ZERO:
    return false

  if abs(self.direction.x) >= abs(self.direction.y):
    new_direction = Vector2.LEFT if self.direction.x <= 0 else Vector2.RIGHT
  else:
    new_direction = Vector2.UP if self.direction.y < 0 else Vector2.DOWN

  if new_direction == self.cardinal_direction:
    return false
  self.cardinal_direction = new_direction
  self.direction_changed.emit(new_direction)
  self.sprite.scale.x = -1 if self.cardinal_direction == Vector2.LEFT else 1
  return true

func update_animation(state: String) -> void:
  self.animation_player.play("%s_%s" % [state, animation_direction()])
  pass

func animation_direction() -> String:
  if self.cardinal_direction == Vector2.DOWN:
    return "down"
  elif self .cardinal_direction == Vector2.UP:
    return "up"
  else:
    return "side"

func _take_damage(hurt_box: HurtBox) -> void:
  if !self.invulnerable:
    self.update_hit_points(-hurt_box.damage)
    if self.hit_points > 0:
      self.player_damaged.emit(hurt_box)
    else:
      self.player_damaged.emit(hurt_box)
      self.update_hit_points(FULL_HEALTH)
  print(self.hit_points)
  pass

func update_hit_points(increment: int) -> void:
  self.hit_points = clamp(self.hit_points + increment, 0, self.max_hit_points)
  PlayerHud.display_hit_points(self.hit_points, self.max_hit_points)
  pass
  
func make_invulverable(_duration: float = 1.0) -> void:
  self.invulnerable = true
  self.hit_box.monitoring = false
  
  await self.get_tree().create_timer(_duration).timeout
  self.invulnerable = false
  self.hit_box.monitoring = true
  pass
 
