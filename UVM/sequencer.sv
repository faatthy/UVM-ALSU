`include "uvm_macros.svh"
package sequencer_package;
import uvm_pkg::*;
import seq_item_package::*;
  class my_sequencer extends uvm_sequencer #( seq_item) ;
`uvm_component_utils(my_sequencer) 
function  new(string name = "my_sequencer",uvm_component parent =null);
super.new(name,parent);    
endfunction   
  endclass  
endpackage
   