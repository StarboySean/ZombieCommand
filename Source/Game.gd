extends Node2D

var waves := [{"zombie0" : 5, "rifle" : 90, "grenade" : 10}, {"zombie0" : 10, "rifle" : 90, "grenade" : 10}]
var wave := 0
var started := false
onready var zombies := 0
onready var zombiesSpawn := 0
onready var zombiesKilled := 0


export var starting_lives := 10
var Zombie0 = preload("res://Source/Zombie-0.tscn")

func _ready():
	for key in waves[wave]:
		if key[0] == "z":
			zombies += waves[wave][key]
	$SurvivorCount.text = str(starting_lives)
	$Wave.text = "wave: " + str(wave+1)
	$Zombies.text = "zombies: " + str(zombies)
	$Weapons.disabled = true 

func _on_Spawner_timeout():
	var zombie0 = Zombie0.instance()
	zombie0.offset = $Weapons.rect_size.x
	zombie0.connect("win", self, "_on_zombie_win")
	add_child(zombie0)
	$Spawner.wait_time *= 0.99


func _on_Weapons_rifle(at):
	$Rifle.cast_to = at - $Rifle.position
	$Rifle.force_raycast_update()
	if $Rifle.is_colliding():
		var collider = $Rifle.get_collider()
		collider.die()
	$Rifle/AudioStreamPlayer.play()

func _on_zombie_win():
	var lives := int($SurvivorCount.text)
	lives -= 1
	$SurvivorCount.text = str(lives)
	if not lives:
		get_tree().change_scene("res://Source/GameOver.tscn")
		
func _on_zombie_die():
	zombiesKilled += 1
	if zombiesKilled >= zombies:
		var next = load("res://src/game.tscn").instance()
		next.wave = wave +1 
		get_tree().change_scene_to(next)
		
func _input(event):
	if started:
		return
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		started = true
		$Wave.visible = false
		$Spawner.start()
		$Weapons.disabled = false
		$Zombies.visible = false
