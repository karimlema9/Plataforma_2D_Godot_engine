extends Actor

export var stomp_impulse: = 1000.0

# calcul quan el PLAYER entra en zona de matar ENEMY fer un impuls cap dalt
func _on_EnemieDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# PLAYER accedix dins del box colider ENEMY - PLAYER die
func _on_EnemieDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

# cada frame per second realitza aquesta accio
# delta millora el moviment del personatge depenent del fps del PC
func _physics_process(delta: float) -> void:
	#cada frame mira si presionem la tecla right
	#if right +1.0 - if left -1.0 
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	#sprite seleccio
	if _velocity.x != 0:
		$Idle/AnimatedSprite.animation = "run"
		$Idle/AnimatedSprite.flip_h = _velocity.x < 0
		$Idle/AnimatedSprite.flip_v = false
	elif _velocity.y != 0:
		$Idle/AnimatedSprite.animation = "jump"	
		$Idle/AnimatedSprite.flip_v = _velocity.y > 0 and is_on_floor()
	else:
		$Idle/AnimatedSprite.animation = "idle"
		
	#collisio

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linier_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var new_velocity: = linier_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	return new_velocity

func calculate_stomp_velocity(linier_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linier_velocity
	out.y = -impulse
	return out

#quan mor suma 1 i desapareix
func die() -> void:
	PlayerData.deaths += 1
	queue_free()
