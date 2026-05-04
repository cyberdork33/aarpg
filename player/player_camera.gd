class_name PlayerCamera extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  LevelManager.tilemap_bounds_changed.connect(self.update_limits)
  self.update_limits(LevelManager.current_tilemap_bounds)
  pass # Replace with function body.

func update_limits(bounds: Array[Vector2]) -> void:
  if bounds == []:
    return
  self.limit_left = int(bounds[0].x)
  self.limit_top = int(bounds[0].y)
  self.limit_right = int(bounds[1].x)
  self.limit_bottom = int(bounds[1].y)
