class_name HeartGUI extends Control

@onready var sprite: Sprite2D = $Sprite2D

var value: int = 2: # Default for Full Heart
  set(_value):
    value = _value
    self.update_sprite()

func update_sprite() -> void:
  self.sprite.frame = self.value
