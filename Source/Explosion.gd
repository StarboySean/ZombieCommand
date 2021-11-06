extends Area2D

func _physics_process(delta):
	for body in get_overlapping_bodies():
		body.queue_free()


func _on_Timer_timeout():
	queue_free()
