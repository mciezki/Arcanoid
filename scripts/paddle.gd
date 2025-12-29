class_name Paddle
extends CharacterBody2D

@export var ball :Ball

const SPEED = 450.0

func _physics_process(_delta: float) -> void:
	position.y = 824.0
	
	if ball:
		if !ball.is_moving:
			ball.before_start_position_x = position.x
		
			if Input.is_action_just_pressed("Start_ball"):
				ball.start_ball()
	
	
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
