extends Area2D

func _ready():
	$AnimatedSprite.play("default")

func _physics_process(delta):
	for body in get_overlapping_bodies():
		body.queue_free()
	


	


func _on_AudioStreamPlayer_finished():
	queue_free()
