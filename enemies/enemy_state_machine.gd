class_name EnemyStateMachine extends Node

var states: Array[EnemyState]
var previous_state: EnemyState
var current_state: EnemyState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  process_mode = Node.PROCESS_MODE_DISABLED
  pass # Replace with function body.

func _process(delta: float) -> void:
  self.change_state(self.current_state.process(delta))
  pass

func _physics_process(delta: float) -> void:
  self.change_state(self.current_state.physics(delta))
  pass

func initialize(_enemy: Enemy) -> void:
  self.states = []

  for node in get_children():
    if node is EnemyState:
      self.states.append(node)

  for state in self.states:
    state.enemy = _enemy
    state.state_machine = self
    state.init()

  if self.states.size() > 0:
    self.change_state( self.states[0])
    self.process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: EnemyState) -> void:
  if new_state == null or new_state == current_state:
    return

  if current_state:
    current_state.exit()

  previous_state = current_state
  current_state = new_state
  current_state.enter()
