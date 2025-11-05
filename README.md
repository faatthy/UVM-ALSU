##  Overview
This project verifies the functionality of the Arithmetic Logic and Shift Unit (ALSU) using the **Universal Verification Methodology (UVM)**.  
The ALSU performs arithmetic, logical, and shift/rotate operations on 3-bit input operands **A** and **B** based on a 3-bit opcode.  
The design includes input bypass options, reduction feature controls, and pipelined output registers.

The main verification objective is to:
- Ensure correctness of generated outputs for all valid operations.
- Detect invalid operation conditions.
- Achieve **100% functional coverage** and high code coverage.

## ALSU Description 
ALSU is a logic unit that can perform logical, arithmetic, and shift operations on input ports 
• Input ports A and B have various operations that can take place depending on the value of 
the opcode. 
• Each input bit except for the clk and rst will be sampled at the rising edge before any 
processing so a D-FF is expected for each input bit at the design entry. 
• The output of the ALSU is registered and is available at the rising edge of the clock.

<img width="778" height="681" alt="image" src="https://github.com/user-attachments/assets/a4866445-9b0d-43a9-8dcc-afeff4ecf86c" />

## Pins Description
<!-- Inputs Table -->
<table border="1" cellspacing="0" cellpadding="6">
  <tr><th>Input</th><th>Width</th><th>Description</th></tr>
  <tr><td>clk</td><td>1</td><td>Input clock</td></tr>
  <tr><td>rst</td><td>1</td><td>Active high asynchronous reset</td></tr>
  <tr><td>A</td><td>3</td><td>Input port A</td></tr>
  <tr><td>B</td><td>3</td><td>Input port B</td></tr>
  <tr><td>cin</td><td>1</td><td>Carry in bit, only valid when FULL_ADDER is ON</td></tr>
  <tr><td>serial_in</td><td>1</td><td>Serial input bit used in shift operations</td></tr>
  <tr><td>red_op_A</td><td>1</td><td>Reduction on A when opcode is OR/XOR</td></tr>
  <tr><td>red_op_B</td><td>1</td><td>Reduction on B when opcode is OR/XOR</td></tr>
  <tr><td>opcode</td><td>3</td><td>Operation select code</td></tr>
  <tr><td>bypass_A</td><td>1</td><td>When high, A is bypassed directly to output</td></tr>
  <tr><td>bypass_B</td><td>1</td><td>When high, B is bypassed directly to output</td></tr>
  <tr><td>direction</td><td>1</td><td>Shift/Rotate direction (0: left, 1: right)</td></tr>
</table>

<br>

<!-- Outputs Table -->
<table border="1" cellspacing="0" cellpadding="6">
  <tr><th>Output</th><th>Width</th><th>Description</th></tr>
  <tr><td>leds</td><td>16</td><td>Blinks when invalid operation occurs, otherwise constant</td></tr>
  <tr><td>out</td><td>6</td><td>ALSU main output</td></tr>
</table>

<br>

<!-- Parameters Table -->
<table border="1" cellspacing="0" cellpadding="6">
  <tr><th>Parameter</th><th>Default Value</th><th>Description</th></tr>
  <tr>
    <td>INPUT_PRIORITY</td>
    <td>A</td>
    <td>Determines priority between A and B during conflict cases</td>
  </tr>
  <tr>
    <td>FULL_ADDER</td>
    <td>ON</td>
    <td>When ON, cin participates in ADD operation</td>
  </tr>
</table>

<br>

<!-- Invalid Cases -->
<h3>Invalid Cases</h3>
<ol>
  <li>Opcode = 110 or 111</li>
  <li>red_op_A or red_op_B = 1 while opcode is not OR or XOR</li>
</ol>

<h4>Output Behavior on Invalid Case</h4>
<ol>
  <li>leds blink</li>
  <li>out is forced to 0</li>
</ol>

<br>

<!-- Opcode Table -->
<table border="1" cellspacing="0" cellpadding="6">
  <tr><th>Opcode</th><th>Operation</th></tr>
  <tr><td>000</td><td>OR</td></tr>
  <tr><td>001</td><td>XOR</td></tr>
  <tr><td>010</td><td>ADD</td></tr>
  <tr><td>011</td><td>MULT</td></tr>
  <tr><td>100</td><td>SHIFT (Shift output by 1 bit)</td></tr>
  <tr><td>101</td><td>ROTATE (Rotate output by 1 bit)</td></tr>
  <tr><td>110</td><td>Invalid</td></tr>
  <tr><td>111</td><td>Invalid</td></tr>
</table>

## UVM Methodology 

```text
uvm_test
 └─ env
     ├─ agent
     │   ├─ sequencer
     │   ├─ driver
     │   └─ monitor
     ├─ scoreboard
     └─ coverage collector (inside monitor / separate class)
