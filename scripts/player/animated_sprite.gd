extends AnimatedSprite2D
class_name CharacterTexture


var _is_on_action: bool = false
var _suffix: String = "_WITH_SWORD"

@export_category("Objects")


func animate(_velocity: Vector2) -> void:
	_verify_direction(_velocity.x)
	
	if _is_on_action:
		return
	
	if not _velocity:
		play("IDLE" + _suffix)
		return
	
	if _velocity.y:
		if _velocity.y > 0:
			play("FALL" + _suffix)
		elif _velocity.y < 0:
			play("JUMP" + _suffix)
		
		return
	
	if _velocity.x:
		play("RUN" + _suffix)


func _verify_direction(_direction: float) -> void:
	if _direction > 0:
		flip_h = false
	elif _direction < 0:
		flip_h = true


func _action_animation(_action_name: String) -> void:
	_is_on_action = true
	play(_action_name + _suffix)


func _on_animation_finished() -> void:
	_is_on_action = false
