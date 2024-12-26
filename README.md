# Automatic Washing Machine Controller
## Project Overview
This project implements a finite state machine (FSM) for an Automatic Washing Machine Controller. The goal of this project is to simulate and control the various stages of a washing machine's operation, including filling water, adding detergent, washing, draining, and spinning. The system ensures that the washing machine operates in a sequence of well-defined states, reacting to different inputs and transitioning between these states based on sensor data.

## Project Objective
The objective of the project is to design an automatic washing machine controller using Verilog, ensuring that the machine performs the following tasks:

Door Locking: The machine locks the door once the washing process begins.

Water Filling: The water valve is turned on until the water level reaches the required threshold.

Detergent Addition: The detergent valve is opened to release detergent when required.

Washing Cycle: The motor is activated to perform the washing process.

Water Drainage: After washing, the water is drained out of the machine.

Dry Spin: Finally, the machine performs a spinning operation to dry the clothes.

Completion: The process is marked as complete when the drying phase ends, and the machine is ready for a reset.
## Key Features
### FSM Design:
The project is based on a Finite State Machine (FSM) with six primary states:

check_door: Verifies if the door is closed and the start button is pressed.

fill_water: Activates the water valve to fill the washing machine with water.

detergent: Turns on the detergent valve to add detergent to the water.

cycle: The washing motor is activated to perform the washing cycle.

drain_water: Drains out the water after the washing cycle.

dry_spin: Spins the clothes to dry them.

### State Transitions: 
The state transitions are controlled based on inputs like start, door_closed, water_level_decrease, detergent_quantity_decrease, cycle_time_out, drained, and spin_time_out.
## Inputs
clk: Clock signal.

reset: Resets the FSM to the initial state.

start: Start button for the washing process.

door_closed: Indicates whether the door is securely closed.

water_level_decrease: Signal indicating when water has been filled to the required level.

detergent_quantity_decrease: Indicates whether detergent has been used up.

cycle_time_out: Trigger to indicate that the washing cycle is completed.

drained: Indicates whether the water has been fully drained.

spin_time_out: Signal indicating that the spin cycle is complete.
## Outputs
### out: 
A 3-bit output controlling the actions of the washing machine:

000: No action.

001: Door lock activated.

010: Water valve on (filling water).

011: Detergent valve on.

100: Motor on (during washing cycle).

101: Drain valve on (during draining).

110: Process done (machine ready for next cycle).
## State Diagram
The FSM transitions through the following states:
check_door: Initial state. Waits for start and door_closed to be 1 before moving to the next state.

fill_water: Activates the water valve if water level is not sufficient. Moves to detergent or cycle based on input signals.

detergent: Activates the detergent valve until detergent is used up, then moves to the cycle state.

cycle: The washing cycle is performed, with the motor activated. Moves to drain_water once the cycle completes.

drain_water: Drains the water out of the washing machine. Moves to dry_spin once draining is complete.

dry_spin: Performs the spin cycle to dry the clothes. Once complete, the machine is ready for the next cycle (check_door).

## Simulation Results
The simulation verifies the functionality of the FSM with different inputs:
The FSM progresses through each state correctly.
The correct output is produced based on the current state, such as activating the door lock, water valve, detergent valve, motor, drain valve, and indicating when the process is complete.
Transitions occur as expected, ensuring that each phase of the washing cycle is executed in the correct order.
## Technologies Used
### Verilog: 
Hardware description language used to design the FSM and simulate the behavior of the washing machine.
### Simulation Tools: 
Tools like Xilinx or Cadence were used to simulate and verify the design.
### Finite State Machine (FSM):
The core concept used for managing the different states of the washing machine.
## Future Improvements
Integration of additional sensors for more realistic feedback (e.g., weight sensor to detect load size).
Adding more states for more detailed control of the washing process (e.g., different washing modes).
Incorporating power optimization techniques to reduce the power consumption of the system.
