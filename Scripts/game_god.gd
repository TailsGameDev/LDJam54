extends Node2D

@onready var level_000 = preload("res://Scenes/level_000.tscn")
@onready var level_001 = preload("res://Scenes/level_001.tscn")
@onready var level_002 = preload("res://Scenes/level_002.tscn")
@onready var level_003 = preload("res://Scenes/level_003.tscn")
@onready var level_004 = preload("res://Scenes/level_004.tscn")

@onready var ship_scene = preload("res://Scenes/ship.tscn")

var ship = null

var level_scenes = []
var level_index = 0

func _ready():
	level_scenes = [level_000, level_001, level_002, level_003, level_004]
	load_next_level()

func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func load_next_level():
	var level_scene = self.level_scenes[self.level_index]
	self.level_index = (self.level_index + 1) % len(self.level_scenes)
	var level = level_scene.instantiate()
	level.ending_portal_reached.connect(on_ending_portal_reached)
	add_child(level)
	#call_deferred("add_child", level)
	
	if self.ship != null:
		self.ship.destroy_self()
	self.ship = ship_scene.instantiate()
	add_child(self.ship)
	#call_deferred("add_child", self.ship)

	self.ship.external_set_position(level.ship_start.position)
	

func on_ending_portal_reached():
	load_next_level()
