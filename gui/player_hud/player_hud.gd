extends CanvasLayer

var hearts: Array[HeartGUI] = []

func _ready() -> void:
  for node in $Control/HFlowContainer.get_children():
    if node is HeartGUI:
      self.hearts.append(node)
      node.visible = false
  pass

func update_hit_points(_hit_points: int, _max_hit_points: int) -> void:
  self.update_max_hit_points(_max_hit_points)
  for heart_index in _max_hit_points:
    self.update_heart(heart_index, _hit_points)
  pass

func update_heart(_index: int, _hit_points: int) -> void:
  var _value: int = clamp(_hit_points - _index * 2, 0, 2)
  self.hearts[_index].value = _value
  pass

func update_max_hit_points(_max_hit_points: int) -> void:
  var _heart_count: int = roundi(_max_hit_points / 2.0)
  for heart_index in self.hearts.size():
    if heart_index < _heart_count:
      self.hearts[heart_index].visible = true
    else:
      self.hearts[heart_index].visible
  pass
