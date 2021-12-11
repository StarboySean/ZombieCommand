extends KinematicBody2D

export var speed := 1.0
var rng = RandomNumberGenerator.new()
var offset := 0.0
var alive := true

signal win

func _ready():
	rng.randomize()
	var viewport_rect := get_viewport_rect()
	var radius :float= $CollisionShape2D.shape.radius 
	position.x = rng.randf_range(radius + offset, viewport_rect.size.x - radius)
	position.y = radius
	speed = rng.randf_range(1, 10)
	
func _process(delta):
	z_index = position.y

func _on_AnimatedSprite_frame_changed():
	move_and_collide(Vector2.DOWN * speed)
func die():
	if alive:
		alive = false
	else:
		return
	$AnimatedSprite.stop()
	var tween = get_node("Tween")
	tween.interpolate_property(self, "rotation_degrees",
		0, 90, 1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object, key):
	if modulate.a:
		var tween = get_node("Tween")
		tween.interpolate_property(self, "modulate:a",
			1, 0, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("win")
	queue_free()
