1. ALSU Description

The ALSU (Arithmetic Logic and Shift Unit) performs logic, arithmetic, and shift/rotate operations on input operands A and B, based on a specified opcode.

All inputs (except clk and rst) are sampled at the rising edge through D-FFs.

The output is registered and becomes available at the next rising clock edge.

2. Inputs
Name	Description
clk	System clock
rst	Asynchronous reset
A	First operand input (3 bits)
B	Second operand input (3 bits)
opcode	Selects the operation to perform
bypass_A, bypass_B	Bypass registers for inputs
red_op_A, red_op_B	Enable reduction operations for A or B
Other shift/rotate control inputs	Used in shift and rotate operations

Each input bit (except clk & rst) has a D-FF before usage.

3. Outputs and Configuration

Main output result is registered and updated on the rising edge.

Additional leds output is used for invalid opcode indication.

4. Opcode Specifications
Opcode Category	Example Operations
Arithmetic	Add, Multiply
Bitwise Logic	AND, OR, XOR
Shifts / Rotates	Shift left/right, Rotate left/right
5. Invalid Cases

Invalid when:

opcode = 110 or 111

red_op_A or red_op_B = 1 while opcode is not OR or XOR

Behavior in Invalid Cases
Signal	Behavior
Output out	Forced to 0
leds	Must blink (signal invalid operation case)
Testbench Requirements
Overall Goal

Verify ALSU behavior under default configuration using constraint-random testing + functional coverage.
