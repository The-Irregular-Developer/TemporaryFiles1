extends Node
class_name State

static var player: Player

static var state_machine : StateMachine

func Enter(): # Upon entering the state
	pass

func Exit(): # Upon exiting the statedddw
	pass
	
func init() -> void:
	pass
	
func Process(_delta: float): # Runs every frame while the state is active		
	pass

func Physics_Update(_delta: float): # Runs every physics tick while the state is active
	pass
	
# What happens with input events in this state (e.g. attack with space bar)?
func HandleInput(InputEvent) -> State:
	return null
