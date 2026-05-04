class_name PlayerStateMachine extends Node

var states: Array[State]
var previous_state: State
var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  self.process_mode = Node.PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  self.change_state(self.current_state.process(delta))
  pass

func _physics_process(delta: float) -> void:
  self.change_state(self.current_state.physics(delta))
  pass

func _unhandled_input(event: InputEvent) -> void:
  self.change_state(self.current_state.handle_input(event))
  pass

func initialize(_player: Player) -> void:
  self.states = []

  for node in self.get_children():
    if node is State:
      self.states.append(node)

  if self.states.size() > 0:
    self.states[0].player = _player
    self.change_state(states[0])
    self.process_mode = Node.PROCESS_MODE_INHERIT



func change_state(new_state: State) -> void:
  if new_state == null or new_state == self.current_state:
    return

  if self.current_state:
    self.current_state.exit()

  self.previous_state = self.current_state
  self.current_state = new_state
  self.current_state.enter()
