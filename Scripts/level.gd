extends Node2D

@onready var ship_start = $ship_start
@onready var ending_portal = $ending_portal

signal ending_portal_reached

func _ready():
	ending_portal.reached.connect(on_ending_portal_reached)

func on_ending_portal_reached():
	ending_portal_reached.emit()
	queue_free()
