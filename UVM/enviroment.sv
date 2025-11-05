`include "uvm_macros.svh"
package enviroment_package;

    import uvm_pkg::*;
    import agent_package::*;
    import seq_item_package::*;
    import scoreboard_package::*;
    import coverage_collector_package::*;

    class enviroment extends uvm_env;

        `uvm_component_utils(enviroment);
        agent                ALSU_agent;
        scoreboard           ALSU_scoreboard;
        coverage_collector   ALSU_coverage_collector;
        virtual ALSU_if vif;
		uvm_analysis_port#(seq_item) agent_analysis_port;
        function new(string name="enviroment",uvm_component parent=null);
            super.new(name,parent);
        endfunction //new()

        function void build_phase (uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(virtual ALSU_if)::get(this,"","vif",vif)) begin
                `uvm_fatal("build_phase","the env unable to get the virtual interface"); 
            end
            uvm_config_db#(virtual ALSU_if)::set(this,"ALSU_agent","vif",vif);
            ALSU_agent=agent::type_id::create("ALSU_agent",this);
            ALSU_scoreboard=scoreboard::type_id::create("ALSU_scoreboard",this);
            ALSU_coverage_collector=coverage_collector::type_id::create("ALSU_coverage_collector",this);
            agent_analysis_port=new("agent_analysis_port",this);
            
        endfunction

        function void connect_phase (uvm_phase phase);
            super.connect_phase(phase);
            ALSU_agent.agent_analysis_port.connect(ALSU_scoreboard.scoreboard_export);
            ALSU_agent.agent_analysis_port.connect(ALSU_coverage_collector.cov_analysis_export);

            
        endfunction
    endclass //enviroment extends superClass
    
endpackage

