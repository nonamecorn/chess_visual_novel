extends CharacterBody2D

@export var speed = 100
@export var acceleration = 500
@export var friction = 500

func get_input_dir():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

func _physics_process(delta: float) -> void:
	var input_vector = get_input_dir()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed,delta * acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_accept"):
		for body in $interaction_area.get_overlapping_bodies():
			if body.has_method("start_dil"):
				$CanvasLayer/dbshechkka.innit(body.start_dil())
				break
