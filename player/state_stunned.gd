class_name State_Stunned extends State

@export var animation_name: String = "stunned"
@export var knockback_speed: float = 200.0
@export var decelerate_speed: float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box: HurtBox
var direction: Vector2

var next_state: State = null

@onready var idle: State = $"../Idle"

func init() -> void:
  self.player.player_damaged.connect(_player_damaged)
  pass


# What happens when player enters this state.
func enter() -> void:
  player.animation_player.animation_finished.connect(self._animation_finished)
  
  self.direction = player.global_position.direction_to(hurt_box.global_position)
  player.velocity = self.direction * -self.knockback_speed
  player.set_direction()
  self.player.update_animation(self.animation_name)
  
  player.make_invulverable(self.invulnerable_duration)
  player.effect_animation_player.play("damaged")
  pass

# What happens when player exits this state.
func exit() -> void:
  self.next_state = null
  player.animation_player.animation_finished.disconnect(_animation_finished)
  pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
  player.velocity -= player.velocity * self.decelerate_speed * _delta
  return self.next_state

# What happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
  return null

# What happens with input events in this state?
func handle_input(_event: InputEvent) -> State:
  return null

func _player_damaged(_hurt_box: HurtBox) -> void:
  self.hurt_box = _hurt_box
  self.state_machine.change_state(self)
  pass

func _animation_finished(_name: String) -> void:
  self.next_state = idle
  pass
