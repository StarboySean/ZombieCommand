extends Node2D

var Zombie0 = preload("res://Source/Zombie-0.tscn")


func _on_Spawner_timeout():
	var zombie0 = Zombie0.instance()
	add_child(zombie0)
