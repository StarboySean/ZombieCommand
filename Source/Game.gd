extends Node2D

export var starting_lives := 10
var Zombie0 = preload("res://Source/Zombie-0.tscn")
func _ready():
	 $Lives.text = str(starting_lives)

func _on_Spawner_timeout():
	var zombie0 = Zombie0.instance()
	zombie0.offset = $Weapons.rect_size.x
	zombie0.connect("win", self, "_on_zombie_win")
	add_child(zombie0)


func _on_Weapons_rifle(at):
	$Rifle.cast_to = at - $Rifle.position
	$Rifle.force_raycast_update()
	if $Rifle.is_colliding():
		var collider = $Rifle.get_collider()
		collider.die()
	$Rifle/AudioStreamPlayer.play()

func _on_zombie_win():
	var lives := int($Lives.text)
	lives -= 1
	$Lives.text = str(lives)
