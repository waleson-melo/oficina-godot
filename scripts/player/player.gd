extends CharacterBody2D
class_name Player


var _max_jump: int = 2
var _jump_count: int = 0
var _on_floor: bool = false

@export_category("Variables")
@export var _speed: float = 200.0
@export var _jump_force: float = -300.0

@export_category("Objects")
@export var _character_texture: CharacterTexture = null


func _physics_process(_delta: float) -> void:
	_vertical_movement(_delta)
	_horizontal_movement(_delta)

	move_and_slide()

	_character_texture.animate(velocity)


func _vertical_movement(_delta: float) -> void:
	if is_on_floor():
		_jump_count = 0
		if not _on_floor:
			_character_texture._action_animation("LAND")
			_on_floor = true
	else:
		_on_floor = false
		velocity += get_gravity() * _delta

	if Input.is_action_just_pressed("jump") and _jump_count < _max_jump:
		_jump_count += 1
		velocity.y = _jump_force


func _horizontal_movement(_delta: float) -> void:
	var _direction: float = Input.get_axis("run_left", "run_right")
	if _direction:
		velocity.x = _direction * _speed
		return

	velocity.x = move_toward(velocity.x, 0, _speed)
