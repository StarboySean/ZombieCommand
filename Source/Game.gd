extends Node2D

var Zombie0 = preload("res://Source/Zombie-0.tscn")


func _on_Spawner_timeout():
	var zombie0 = Zombie0.instance()
	zombie0.offset = $Weapons.rect_size.x
	add_child(zombie0)


func _on_Weapons_rifle(at):
	$Rifle.cast_to = at - $Rifle.position
	$Rifle.force_raycast_update()
	if $Rifle.is_colliding():
		var collider = $Rifle.get_collider()
		collider.queue_free()
	$Rifle/AudioStreamPlayer.play()
