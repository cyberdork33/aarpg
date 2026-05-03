class_name PlayerInteractionsHost extends Node2D

@onready var player: Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  player.DirectionChanged.connect(UpdateDirection)
  pass # Replace with function body.

func UpdateDirection(new_direction: Vector2) -> void:
  match new_direction:
    Vector2.DOWN:
      rotation = 0
    Vector2.UP:
      rotation = TAU / 2
    Vector2.LEFT:
      rotation = TAU / 4
    Vector2.RIGHT:
      rotation = -TAU / 4
    _:
      rotation = 0
  pass
