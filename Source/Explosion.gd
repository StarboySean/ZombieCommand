extends Area2D

func _ready():
	z_index = position.y
	$AnimatedSprite.play("default")

func _physics_process(delta):
	for body in get_overlapping_bodies():
		body.die()
	


	


func _on_AudioStreamPlayer_finished():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	$CollisionShape2D.queue_free()
