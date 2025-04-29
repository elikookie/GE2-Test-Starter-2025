extends CharacterBody3D

const MAX_SPEED = 3.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle flying up.
	var startSpeed = 0
	if Input.is_action_pressed("up"):
		while startSpeed < MAX_SPEED:
			startSpeed = startSpeed + 0.1
			velocity.y = global_position.y + startSpeed
		velocity.y = global_position.y + startSpeed
	else:
		while startSpeed != 0:
			startSpeed = startSpeed - 0.1
			velocity.y = global_position.y + startSpeed

	var input_dir := Input.get_vector("left", "right", "forward", "reverse")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * MAX_SPEED
		velocity.z = direction.z * MAX_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MAX_SPEED)
		velocity.z = move_toward(velocity.z, 0, MAX_SPEED)

	move_and_slide()
