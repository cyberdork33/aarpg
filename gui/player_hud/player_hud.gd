extends CanvasLayer

const max_heart_value: int = 2
var heart_containers: Array[HeartGUI] = []

func _ready() -> void:
  for node in $Control/HFlowContainer.get_children():
    if node is HeartGUI:
      self.heart_containers.append(node)
      node.visible = false
  pass

func display_hit_points(_hit_points: int, _max_hit_points: int) -> void:
  self.display_max_containers(_max_hit_points)
  for heart_index in _max_hit_points:
    self.fill_heart(heart_index, _hit_points)
  pass

func fill_heart(_index: int, _hit_points: int) -> void:
  var _value: int = clamp(_hit_points - _index * 2, 0, 2)
  self.heart_containers[_index].value = _value
  pass

func display_max_containers(_max_hit_points: int) -> void:
  var _displayed_heart_count: int = roundi(_max_hit_points / 2.0)
  for heart_index in self.heart_containers.size():
    if heart_index < _displayed_heart_count:
      self.heart_containers[heart_index].visible = true
    else:
      self.heart_containers[heart_index].visible = false
  pass
