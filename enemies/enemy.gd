class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged(hurt_box: HurtBox)
signal enemy_destroyed(hurt_box: HurtBox)

@export var hit_points: int = 3

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hit_box: HitBox = $HitBox
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  self.state_machine.initialize(self)
  self.player = PlayerManager.player
  self.hit_box.damaged.connect(_take_damage)
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass

func _physics_process(_delta: float) -> void:
  move_and_slide()

func set_direction(_new_direction: Vector2) -> bool:
  self.direction = _new_direction

  var new_direction: Vector2 = self.cardinal_direction

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
  self.animation_player.play("%s_%s" % [state, self.animation_direction()])
  pass

func animation_direction() -> String:
  if self.cardinal_direction == Vector2.DOWN:
    return "down"
  elif self.cardinal_direction == Vector2.UP:
    return "up"
  else:
    return "side"

func _take_damage(hurt_box: HurtBox) -> void:
  if !self.invulnerable:
    self.hit_points -= hurt_box.damage
  if self.hit_points > 0:
    self.enemy_damaged.emit(hurt_box)
  else:
    self.enemy_destroyed.emit(hurt_box)
  pass
