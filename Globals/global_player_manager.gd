extends Node

const PLAYER = preload("uid://hj2knyuyv8d3") 

var player: Player
var player_spawned: bool = false

func _ready() -> void:
  self.add_player_instance()
  await self.get_tree().create_timer(0.2).timeout
  self.player_spawned = true
  pass

func add_player_instance() -> void:
  self.player = PLAYER.instantiate()
  self.add_child(self.player)
  pass

func set_player_position(_new_position: Vector2) -> void:
  self.player.global_position = _new_position
  pass

func set_as_parent(_new_parent: Node2D) -> void:
  if self.player.get_parent():
    self.player.reparent(_new_parent)
  else:
    _new_parent.add_child(self.player)
  pass

func unparent_player(_old_parent: Node2D) -> void:
  _old_parent.remove_child(self.player)
  pass
