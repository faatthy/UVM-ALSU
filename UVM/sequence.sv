`include "uvm_macros.svh" 
package sequence_package; 
    import uvm_pkg::*; 
    import seq_item_package::*; 
    class sequence_reset extends uvm_sequence #(seq_item); 
        `uvm_object_utils(sequence_reset); 
        seq_item sequence_item; 
        function new(string name="sequence_reset"); 
            super.new(name); 
        endfunction 
     
        task  body; 
            sequence_item=seq_item::type_id::create("sequence_item"); 
            start_item(sequence_item); 
            sequence_item.reset=1; 
            sequence_item.serial_in=0; 
            sequence_item.red_op_B= 0; 
            sequence_item.red_op_A = 0; 
            sequence_item.bypass_A=0; 
            sequence_item.bypass_B=0; 
            sequence_item.cin=0; 
            sequence_item.direction=0; 
            sequence_item.A=0; 
            sequence_item.B=0; 
            sequence_item.opcode=0; 
            finish_item(sequence_item); 
        endtask  
    endclass 
    class sequence_main extends uvm_sequence #(seq_item); 
        `uvm_object_utils(sequence_main); 

        seq_item sequence_item; 
         function new(string name="sequence_main"); 
         super.new(name); 
         endfunction  

         task body; 
            repeat(1000) begin 
             sequence_item=seq_item::type_id::create("sequence_item"); 
             start_item(sequence_item); 
                assert (sequence_item.randomize()); 
             finish_item(sequence_item);     
            end 
         endtask       
endclass 

class sequence_direct extends uvm_sequence #(seq_item); 
    `uvm_object_utils(sequence_direct);     
         seq_item sequence_item; 
         function new(string name="sequence_direct"); 
         super.new(name); 
         endfunction  
         task body;               
            sequence_item=seq_item::type_id::create("sequence_item"); 
             start_item(sequence_item); 
             sequence_item.A=50; 
             sequence_item.B=50; 
                #1; 
                sequence_item.opcode=3'b000; 
                    #2; 
                    sequence_item.opcode=3'b001; 
                    #2;  
                    sequence_item.opcode=3'b010; 
                    #2; 
                    sequence_item.opcode=3'b011; 
                    #2; 
                    sequence_item.opcode=3'b100; 
                    #2; 
                    sequence_item.opcode=3'b101; 
                    #2; 
             finish_item(sequence_item);            
         endtask     
endclass 
endpackage

