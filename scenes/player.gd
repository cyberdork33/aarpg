class_name Player extends CharacterBody2D

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var move_speed: float = 100.0
var state: String = "idle"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = direction * move_speed
	
	if set_state() or set_direction():
		update_animation()


func _physics_process(delta: float) -> void:
	move_and_slide()

func set_direction() -> bool:
	var new_direction: Vector2 = cardinal_direction
	
	if direction == Vector2.ZERO:
		return false
	
	if abs(direction.y) > abs(direction.x):
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	else
		new_direc
	return true
	
func set_state() -> bool:
	var new_state: String = "idle" if direction == Vector2.ZERO else "walk"
	
	if new_state == state:
		return false
	state = new_state
	return true

func update_animation() -> void:
	
	animation_player.play("%s_%s" % [state, animation_direction()])

func animation_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
