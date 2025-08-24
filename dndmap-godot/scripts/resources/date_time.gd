class_name DateTime extends Resource

@export_range(0,59) var seconds: int = 0
@export_range(0,59) var minutes: int = 0
@export_range(0,23) var hours: int = 0
@export var days: int = 0

func change_time(s: int = 0, m: int = 0, h: int = 0, d: int = 0): ## does not account for adding more than their cap
	seconds += s
	
	if seconds >= 60:
		seconds -= 60
		minutes += 1
		
	minutes += m
	
	if minutes >= 60:
		minutes -= 60
		hours += 1
		
	hours += h
	
	if hours >= 24:
		hours -= 24
		days += 1
		
	days += d
