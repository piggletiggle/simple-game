extends Node2D

@export var health = 100

func take_damage(damage_taken: int):
    health -= damage_taken
    print("got hit for ", damage_taken)
    print("hp: ", health)
