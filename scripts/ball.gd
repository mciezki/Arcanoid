class_name Ball
extends CharacterBody2D
@onready var hit_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var speed := 450.0
var is_moving := false
var before_start_position_x := 352.0

func _ready() -> void:
	add_to_group("balls")
	if !is_moving:
		velocity = Vector2(0,0).normalized() * speed
	
func _physics_process(delta: float) -> void:
	if !is_moving:
		position = Vector2(before_start_position_x, position.y)
		
	var collision = move_and_collide(velocity * delta)
	collision_detection(collision, self)
	
	if global_position.y > get_viewport_rect().end.y + 50:
		destroy_ball()
	
#_______________

func collision_detection(collision: KinematicCollision2D, ball: Ball) -> void:
	if collision:
		var collider = collision.get_collider()
		
		if collider is Paddle:
			var offset_x = ball.position.x - collider.position.x
			var new_direction = Vector2(offset_x, -100.0).normalized()
			hit_sfx.play(0)
			
			ball.velocity = new_direction * ball.speed
		else:
			ball.velocity = ball.velocity.bounce(collision.get_normal())
		
		if collider is Diamond:
			collider.destroy_diamond()
		
		if collider is Sapphire:
			collider.destroy_sapphire(ball)
			

#_________________

func start_ball() -> void:
	velocity = Vector2(0,-200).normalized() * speed
	is_moving = true
	
func destroy_ball() -> void:
	Main.balls -= 1
	queue_free()
