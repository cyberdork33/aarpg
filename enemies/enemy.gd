class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

@export var hit_points: int = 3

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player: Player
var invulnerable: bool = false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: EnemyStateMachine = $EnemyStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  self.state_machine.initialize(self)
  player = PlayerManager.player
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
  pass

func _physics_process(_delta: float) -> void:
  move_and_slide()

func set_direction(_new_direction: Vector2) -> bool:
  direction = _new_direction

  var new_direction: Vector2 = cardinal_direction

  if direction == Vector2.ZERO:
    return false

  if abs(direction.x) >= abs(direction.y):
    new_direction = Vector2.LEFT if direction.x <= 0 else Vector2.RIGHT
  else:
    new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN

  if new_direction == cardinal_direction:
    return false
  cardinal_direction = new_direction
  direction_changed.emit(new_direction)
  sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
  return true

func update_animation(state: String) -> void:
  animation_player.play("%s_%s" % [state, animation_direction()])
  pass

func animation_direction() -> String:
  if cardinal_direction == Vector2.DOWN:
    return "down"
  elif cardinal_direction == Vector2.UP:
    return "up"
  else:
    return "side"
