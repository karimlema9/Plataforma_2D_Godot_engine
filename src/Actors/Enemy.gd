extends "res://src/Actors/Actor.gd"

# funcio mentres el enmic no estigue a la pantalla amb el PLAYER no es moura
func _ready() -> void:
	set_physics_process(false)
	_velocity.x = speed.x

export var score: = 100

func _on_JumpDetector_body_entered(area: PhysicsBody2D) -> void:
	if area.global_position.y > get_node("JumpDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	die()

# moviments
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if _velocity.x > 0:
		$IdleEnemy/AnimatedSprite.flip_h = false
	else:
		$IdleEnemy/AnimatedSprite.flip_h = true

func die() -> void:
	PlayerData.score += score
	queue_free()
	
