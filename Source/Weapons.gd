extends ItemList

enum Weapon{
	UNARMED,
	RIFLE,
	ROCKET	
}


func _ready():
	add_item("rifle")
	add_item("rocket")



func _on_Weapons_item_selected(index):
	match index + 1:
		Weapon.RIFLE:
			pass
		Weapon.ROCKET:
			pass
