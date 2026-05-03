class_name EnemyStateWander extends EnemyState

@export var animation_name: String = "walk"
@export var walk_speed: float = 30.0

@export_category("AI")
@export var state_animation_duration: float = 0.7
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: EnemyState

var _timer: float = 0.0
var _direction: Vector2

# What happens when we initialize this state?
func init() -> void:
  pass # Replace with function body.

# What happens when enemy enters this state?
func enter() -> void:
  self._timer = randi_range(self.state_cycles_min, self.state_cycles_max) * self.state_animation_duration
  var possible_directions = [Vector2.UP, Vector2.DOWN, Vector2.RIGHT, Vector2.LEFT]
  self._direction = possible_directions.pick_random()
  enemy.velocity = self._direction * self.walk_speed
  enemy.set_direction(self._direction)
  enemy.update_animation(self.animation_name)
  pass

# What happens when enemy exits this state?
func exit() -> void:
  pass

# What happens during the _process update in this state?
func process(_delta: float) -> EnemyState:
  self._timer -= _delta
  if self._timer <= 0:
    return self.next_state
  return null

# What happens during the _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
  return null
