class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

signal DirectionChanged(direction: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  state_machine.Initialize(self)
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

  # Retrieve direction input
  # Separate Input Map actions for DPad and Joysticks. Putting both
  # on one action means that when you use get_vector(), you read the dpad input
  # as well as the noise on the joysticks as the same time. This leads to capturing
  # non cardinal directions when only using DPad.
  direction = Input.get_vector("left", "right", "up", "down")
  if direction == Vector2.ZERO: # Only attempt to get joystick input when no other direction data is obtained.
    direction = Input.get_vector("joy_left", "joy_right", "joy_up", "joy_down")

  pass


func _physics_process(_delta: float) -> void:
  move_and_slide()

func set_direction() -> bool:
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
  DirectionChanged.emit(new_direction)
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
