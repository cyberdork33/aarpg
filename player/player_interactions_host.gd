class_name PlayerInteractionsHost extends Node2D

@onready var player: Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  player.direction_changed.connect(self.update_direction)
  pass # Replace with function body.

func update_direction(new_direction: Vector2) -> void:
  match new_direction:
    Vector2.DOWN:
      self.rotation = 0
    Vector2.UP:
      self.rotation = TAU / 2
    Vector2.LEFT:
      self.rotation = TAU / 4
    Vector2.RIGHT:
      self.rotation = -TAU / 4
    _:
      self.rotation = 0
  pass
