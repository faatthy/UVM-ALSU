`include "uvm_macros.svh" 

import uvm_pkg::*;
import test_package::*;
module top();
    
    bit clk; 
 
 initial begin 
     clk=0; 
     forever begin 
         #1 clk=~clk; 
     end 
 end
 ALSU_if alsu_if(clk);
 ALSU UUT(alsu_if.DUT);
 ALSU_Gold DUT_GOLD(alsu_if.DUT_GOLD);
 bind ALSU SVA assertions (alsu_if.DUT);
 initial 
 begin
    uvm_config_db #(virtual ALSU_if)::set(null,"uvm_test_top","ALSU_if",alsu_if);
    run_test("test");
 end
endmodule
