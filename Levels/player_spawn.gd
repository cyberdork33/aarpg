extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  self.visible = false
  if !PlayerManager.player_spawned:
    PlayerManager.set_player_position(self.global_position)
    PlayerManager.player_spawned = true
  pass
