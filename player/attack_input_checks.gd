extends Node

# Helper function to support the input checking logic
# 
static func _last_n_input(
	input_registry,
	find_input: int,
	excluded_inputs,
	start: int,
	between: int
) -> int:
	var index = -1
	for i in range(start, start+between):
		# Avoid out-of-range errors
		if i >= 30: return -1
		if input_registry[i] == find_input:
			index = i 
		if int(input_registry[i]) in excluded_inputs: return -1
	return index

# Check for 623X input. Conditions: 
# (3) must have been first input in the past 6 frames
# (2) must be input before (3) with no other inputs in between, within 6 frames
# There cannot be a backwards input (1/4/7) between (6) and (2) 
static func check_623X(input_registry):
	var hit3 = _last_n_input(input_registry, 3, [], 0, 6)
	if hit3 == -1: return false
	var hit2 = _last_n_input(input_registry, 2, [1,4,5,6,7,8,9], hit3, 6)
	if hit2 == -1: return false
	var hit6 = _last_n_input(input_registry, 6, [1,4,7], hit2, 10)
	if hit6 == -1: return false
	return true

# Check for 236X input. Conditions: 
# (6) must have been first input in the past 6 frames, and none of the inputs can be more than 6 frames apart.
# (There cannot be any other inputs 
static func check_236X(input_registry):
	var hit6 = _last_n_input(input_registry, 6, [], 0, 6)
	if hit6 == -1: return false
	var hit3 = _last_n_input(input_registry, 3, [1,2,4,5,7,8,9], hit6, 6)
	if hit3 == -1: return false
	var hit2 = _last_n_input(input_registry, 2, [1,4,5,6,7,8,9], hit3, 6)
	if hit2 == -1: return false
	return true

static func check_22X(input_registry):
	var hit2 = _last_n_input(input_registry, 2, [], 0, 2)
	if hit2 == -1: return false
	var hit_neutral = max(
		_last_n_input(input_registry, 5, [], hit2, 6),
		_last_n_input(input_registry, 8, [], hit2, 6)
	)
	if hit_neutral == -1: return false
	var hit2_2 = _last_n_input(input_registry, 2, [], hit_neutral, 2)
	if hit2_2 == -1: return false
	return true
