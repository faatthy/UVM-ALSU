`include "uvm_macros.svh" 
package monitor_package;
    
    import uvm_pkg::*;
    import seq_item_package::*;
    class monitor extends uvm_monitor;
        `uvm_component_utils(monitor);
        virtual ALSU_if monitor_vif;
        seq_item monitor_seq_item;
        uvm_analysis_port #(seq_item) monitor_analysis_port;
        function new(string name="monitor",uvm_component parent=null);

            super.new(name,parent);
            
        endfunction //new()
        function void build_phase(uvm_phase phase);

            super.build_phase(phase);
            if (!uvm_config_db#(virtual ALSU_if)::get(this, "", "vif", monitor_vif)) begin
                `uvm_fatal("Monitor", "Failed to get virtual interface!")
            end

            monitor_analysis_port=new("monitor_analysis_port",this);
            
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                monitor_seq_item=seq_item::type_id::create("monitor_seq_item");
                @(negedge monitor_vif.clk);
                monitor_seq_item.reset=monitor_vif.reset;
                monitor_seq_item.direction=monitor_vif.direction; 
                monitor_seq_item.cin=monitor_vif.cin; 
                monitor_seq_item.serial_in=monitor_vif.serial_in; 
                monitor_seq_item.bypass_A=monitor_vif.bypass_A; 
                monitor_seq_item.bypass_B=monitor_vif.bypass_B; 
                monitor_seq_item.red_op_A=monitor_vif.red_op_A; 
                monitor_seq_item.red_op_B=monitor_vif.red_op_B; 
                monitor_seq_item.A=monitor_vif.A; 
                monitor_seq_item.B=monitor_vif.B; 
                monitor_seq_item.opcode=monitor_vif.opcode; 
                monitor_seq_item.out=monitor_vif.out; 
                monitor_seq_item.leds=monitor_vif.leds; 
                monitor_seq_item.out_golden_model=monitor_vif.out_golden_model; 
                monitor_seq_item.leds_golden_model=monitor_vif.leds_golden_model; 
                monitor_analysis_port.write(monitor_seq_item);
                `uvm_info("run_phase",monitor_seq_item.convert2string(),UVM_HIGH); 

            end
        endtask

    endclass //monitor extends superClass

endpackage
