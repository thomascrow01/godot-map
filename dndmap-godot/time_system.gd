class_name TimeSystem extends Node


@export var time_label: Label
@export var date_time: DateTime

@onready var day_cycle: AnimationPlayer = $DayCycle

func _ready() -> void:
	if date_time:
		if time_label:
			time_label.text = str(date_time.hours) + ":" + str(date_time.minutes)
		if day_cycle:
			# get percentage of day done, but midday is 0 and 1 rather than 0.5
			var day_percentage: float = clampf(0.5 + date_time.hours / 24.0 + date_time.minutes / 1440.0 + date_time.seconds / 86400.0, 0.0, 1.0) 
			day_cycle.seek(day_percentage * 10.0, true)
			day_cycle.pause()

func update_time(s: int = 0, m: int = 0, h: int = 0, d: int = 0) -> void:
	
	if date_time:
		date_time.change_time(s,m,h,d)
		if time_label:
			time_label.text = str(date_time.hours) + ":" + str(date_time.minutes)
		if day_cycle:
			# get percentage of day done, but midday is 0 and 1 rather than 0.5
			var day_percentage: float = clampf(0.5 + date_time.hours / 24.0 + date_time.minutes / 1440.0 + date_time.seconds / 86400.0, 0.0, 1.0) 
			day_cycle.seek(day_percentage * 10.0, true)
			day_cycle.pause()
