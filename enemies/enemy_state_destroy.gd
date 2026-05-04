class_name EnemyStateDestroy extends EnemyState

@export var animation_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0

@export_category("AI")

var _direction: Vector2
var _damage_position: Vector2

# What happens when we initialize this state?
func init() -> void:
  enemy.enemy_destroyed.connect(_on_enemy_destroyed)
  pass # Replace with function body.

# What happens when enemy enters this state?
func enter() -> void:

  enemy.invulnerable = true

  # Set direction and velocity
  self._direction = enemy.global_position.direction_to(self._damage_position)
  enemy.set_direction(self._direction)
  enemy.velocity = self._direction * -self.knockback_speed
  
  # play the animation
  enemy.update_animation(self.animation_name)
  enemy.animation_player.animation_finished.connect(self._on_animation_finished)
  pass

# What happens when enemy exits this state?
func exit() -> void:
  pass

# What happens during the _process update in this state?
func process(delta: float) -> EnemyState:
  enemy.velocity -= enemy.velocity * self.decelerate_speed * delta
  return null

# What happens during the _physics_process update in this state?
func physics(_delta: float) -> EnemyState:
  return null

func _on_enemy_destroyed(hurt_box: HurtBox) -> void:
  self._damage_position = hurt_box.global_position
  state_machine.change_state(self)
  pass

func _on_animation_finished(_animation_name: String) -> void:
  enemy.queue_free()
  pass
