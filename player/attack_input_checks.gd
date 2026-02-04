extends Node

# Check for 623X input. Conditions: 
# (3) must have been first input in the past 6 frames, and none of the inputs can be more than 6 frames apart.
# (2) must be input before (3) with no other inputs in between
# There cannot be a backwards input (1/4/7) between (6) and (2) 
static func check_623X(input_registry):
	var hit6 = false
	var hit2 = false
	var hit3 = false
	var between = 0
	var idx = 0
	for input in input_registry:
		if !hit6:
			if input == 6:
				hit6 = true
				between = -1
		elif !hit2:
			if input == 6: between = -1
			if input == 1 or input == 4 or input == 7: return false
			if input == 2:
				hit2 = true
				between = -1
		else:
			if input == 3: return true if input_registry.size() - idx <= 6 else false
			elif input != 2: return false
		between += 1
		idx += 1
		if hit6 and between > 6: return false
	print(input_registry)
	return false

# Check for 236X input. Conditions: 
# (6) must have been input in the past 6 frames, and none of the inputs can be more than 6 frames apart.
# (2) must be input before (3) with no other inputs in between
# There cannot be a backwards input (1/4/7) between (6) and (2) 
static func check_236X(input_registry):
	pass	

static func check_22X(input_registry):
	pass
