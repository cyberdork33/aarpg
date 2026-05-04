class_name LevelTilemap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  LevelManager.change_tilemap_bounds(self.get_tilemap_bounds())
  pass # Replace with function body.

func get_tilemap_bounds() -> Array[Vector2]:
  var rect = self.get_used_rect()  # Get the tilemap rect
  var bounds: Array[Vector2] = []
  bounds.append(
    Vector2(rect.position * self.tile_set.tile_size)
  )
  bounds.append(
    Vector2(rect.end * self.tile_set.tile_size)
  )
  return bounds
