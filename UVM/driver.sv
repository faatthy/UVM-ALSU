`include "uvm_macros.svh"
package driver_package;

    import uvm_pkg::*;
    import seq_item_package::*;
    import sequencer_package::*;

    class driver extends uvm_driver #(seq_item);

        `uvm_component_utils(driver);
        virtual ALSU_if driver_vif;
        seq_item driver_seq_item;
        function new(string name ="driver",uvm_component parent = null);
            super.new(name,parent);
        endfunction //new()
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual ALSU_if)::get(this, "", "vif", driver_vif)) begin
                `uvm_fatal("driver", "Failed to get virtual interface!")
            end
        endfunction
    
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                driver_seq_item=seq_item::type_id::create("driver_seq_item");
                seq_item_port.get_next_item(driver_seq_item);
                driver_vif.reset=driver_seq_item.reset; 
                driver_vif.direction=driver_seq_item.direction; 
                driver_vif.cin=driver_seq_item.cin; 
                driver_vif.serial_in=driver_seq_item.serial_in; 
                driver_vif.bypass_A=driver_seq_item.bypass_A; 
                driver_vif.bypass_B=driver_seq_item.bypass_B; 
                driver_vif.red_op_A=driver_seq_item.red_op_A; 
                driver_vif.red_op_B=driver_seq_item.red_op_B; 
                driver_vif.A=driver_seq_item.A; 
                driver_vif.B=driver_seq_item.B; 
                driver_vif.opcode=driver_seq_item.opcode;
                @(negedge driver_vif.clk);
                driver_seq_item.out=driver_vif.out; 
                driver_seq_item.leds=driver_vif.leds; 
                driver_seq_item.out_golden_model=driver_vif.out_golden_model; 
                driver_seq_item.leds_golden_model=driver_vif.leds_golden_model; 
                            seq_item_port.item_done(); 
               `uvm_info("run_phase",driver_seq_item.convert2string_stimulus(),UVM_HIGH);
            end
        endtask


    endclass //driver extends superClass
    
endpackage
