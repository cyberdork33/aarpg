class_name LevelTilemap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  LevelManager.ChangeTilemapBounds(GetTilemapBounds())
  pass # Replace with function body.

func GetTilemapBounds() -> Array[Vector2]:
  var rect = get_used_rect()  # Get the tilemap rect
  var bounds: Array[Vector2] = []
  bounds.append(
    Vector2(rect.position * tile_set.tile_size)
  )
  bounds.append(
    Vector2(rect.end * tile_set.tile_size)
  )
  return bounds
