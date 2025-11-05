`include "uvm_macros.svh"
package agent_package;

    import uvm_pkg::*;
    import seq_item_package::*;
    import driver_package::*;
    import monitor_package::*;
    import sequencer_package::*;
    import config_package::*;

    class agent extends uvm_agent;
        `uvm_component_utils(agent);
        config_object   ALSU_config;
        driver          ALSU_driver;
        monitor         ALSU_monitor;
        my_sequencer       ALSU_sequencer;
        uvm_analysis_port #(seq_item)agent_analysis_port;
        virtual ALSU_if vif;

        function new(string name="agent",uvm_component parent=null);
            super.new(name,parent);
            
        endfunction //new()

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual ALSU_if)::get(this,"","vif",vif)) begin
                `uvm_fatal("build_phase","the Agent unable to get the virtual interface"); 
            end
            uvm_config_db#(virtual ALSU_if)::set(this,"ALSU_driver","vif",vif);       
            uvm_config_db#(virtual ALSU_if)::set(this,"ALSU_monitor","vif",vif);

                ALSU_driver=driver::type_id::create("ALSU_driver",this);
                ALSU_sequencer=my_sequencer::type_id::create("ALSU_sequencer",this);
            ALSU_monitor=monitor::type_id::create("ALSU_monitor",this);
            agent_analysis_port=new("agent_analysis_port",this);
            
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
                ALSU_driver.seq_item_port.connect(ALSU_sequencer.seq_item_export);
               // ALSU_driver.driver_vif=vif;
            

           // ALSU_monitor.monitor_vif=vif;
            ALSU_monitor.monitor_analysis_port.connect(this.agent_analysis_port);
            
        endfunction
    endclass //agent extends superClass

endpackage
