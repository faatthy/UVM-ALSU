interface ALSU_if (clk); 
    input bit clk; 
    logic reset,cin,red_op_A,red_op_B,bypass_A,bypass_B,direction,serial_in; 
    logic [2:0] opcode; 
    logic signed [2:0] A,B; 
    logic [15:0] leds,leds_golden_model; 
    logic [5:0] out; 
    logic [5:0] out_golden_model; 
     
    modport DUT ( 
    input clk,reset,cin,red_op_A,red_op_B,bypass_A,bypass_B,direction,serial_in,opcode, 
    A,B,output out,leds 
    ); 
   
    modport DUT_GOLD ( 
    input clk,reset,cin,red_op_A,red_op_B,bypass_A,bypass_B,direction,serial_in,opcode, 
    A,B,output out_golden_model,leds_golden_model 
    ); 
   
  endinterface