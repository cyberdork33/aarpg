class_name EnemyStateIdle extends EnemyState

@export var animation_name: String = "idle"

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: EnemyState

var _timer: float = 0.0

# What happens when we initialize this state?
func init() -> void:
  pass # Replace with function body.

# What happens when enemy enters this state?
func enter() -> void:
  enemy.velocity = Vector2.ZERO
  self._timer = randf_range(self.state_duration_min, self.state_duration_max)
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
