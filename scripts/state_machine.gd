extends Node
class_name StateMachine

var current_state: State
var prev_state : State
var states: Array[State]

func _ready() -> void: # A built-in virtual function is a special method that runs at specific events in a node's lifecycle.
	pass
	

func _process(delta : float) -> void: # Called every frame. 'delta' is the elapsed time since the previous frame.
	ChangeState(current_state.Process(delta))
	pass

func _physics_process(delta : float) -> void:
	ChangeState(current_state.Physics_Update(delta))
	pass

func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize(_player : Player) -> void:
	states = []
	
	for child in get_children():
		if child is State:
			states.append(child)
	
	if states.size() == 0:
		return
		
	states[0].player = _player
	states[0].state_machine = self
	
	for state in states:
		state.init()
	
	ChangeState(states[0]) # Upon starting state machine, set the initial state as the first state

func ChangeState(new_state : State) -> void: # Changing between states
	
	if new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.Enter()
	pass
