class_name State extends Node

# Reference to the player that the state belongs to
static var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.

# What happens when player enters this state.
func enter() -> void:
  pass

# What happens when player exits this state.
func exit() -> void:
  pass

# What happens during the _process update in this state?
func process(_delta: float) -> State:
  return null

# What happens during the _physics_process update in this state?
func physics(_delta: float) -> State:
  return null

# What happens with input events in this state?
func handle_input(_event: InputEvent) -> State:
  return null
