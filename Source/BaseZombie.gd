extends KinematicBody2D

export var speed := 1.0
var rng = RandomNumberGenerator.new()
var offset := 0.0

func _ready():
	rng.randomize()
	var viewport_rect := get_viewport_rect()
	var radius :float= $CollisionShape2D.shape.radius 
	position.x = rng.randf_range(radius + offset, viewport_rect.size.x - radius)
	position.y = radius
	
func _process(delta):
	z_index = position.y

func _on_AnimatedSprite_frame_changed():
	move_and_collide(Vector2.DOWN * speed)
func die():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "rotation_degrees",
		0, 90, 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object, key):
	queue_free()
