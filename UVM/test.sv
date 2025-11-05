`include "uvm_macros.svh"
package test_package;
    import uvm_pkg::*;
    import enviroment_package::*;
    import sequence_package::*;
    import config_package::*;

    class test extends uvm_test;
        `uvm_component_utils(test);
        enviroment ALSU_env;
        sequence_direct ALSU_sequence_direct;
        sequence_reset  ALSU_sequence_reset;
        sequence_main   ALSU_sequence_main;
        config_object   ALSU_config_test;
        virtual ALSU_if vif;
        
        function new(string name="test",uvm_component parent=null);
            super.new(name,parent);
        endfunction //new()

        function void build_phase(uvm_phase phase);
        
            super.build_phase(phase);

            ALSU_env=enviroment::type_id::create("ALSU_env",this);
            ALSU_config_test=config_object::type_id::create("ALSU_config_test",this);
            ALSU_sequence_reset=sequence_reset::type_id::create("ALSU_sequence_reset",this);
            ALSU_sequence_main=sequence_main::type_id::create("ALSU_sequence_main",this);
            ALSU_sequence_direct=sequence_direct::type_id::create("ALSU_sequence_direct",this);
            if (!uvm_config_db#(virtual ALSU_if)::get(this,"","ALSU_if",vif)) begin
                `uvm_fatal("build_phase","the test unable to get the virtual interface"); 
            end
			ALSU_config_test.sel_mod=UVM_ACTIVE;
            uvm_config_db#(virtual ALSU_if)::set(this,"ALSU_env","vif",vif);
        endfunction

        task run_phase(uvm_phase phase);
            super.connect_phase(phase);

            phase.raise_objection(this);
            `uvm_info("run_phase","reset asserted",UVM_LOW); 
            ALSU_sequence_reset.start(ALSU_env.ALSU_agent.ALSU_sequencer); 
            `uvm_info("run_phase","reset deasserted",UVM_LOW); 
 
            //main sequence 
            `uvm_info("run_phase","stimulus generated started",UVM_LOW); 
            ALSU_sequence_direct.start(ALSU_env.ALSU_agent.ALSU_sequencer); 
            `uvm_info("run_phase","stimulus generated ended",UVM_LOW); 
 
            //direct test sequence 
             `uvm_info("run_phase","stimulus generated started",UVM_LOW); 
            ALSU_sequence_main.start(ALSU_env.ALSU_agent.ALSU_sequencer);     
              `uvm_info("run_phase","stimulus generated ended",UVM_LOW); 
            phase.drop_objection(this);
        endtask
    endclass //test extends superClass
    
endpackage

