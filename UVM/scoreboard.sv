`include "uvm_macros.svh"
package scoreboard_package;

    import uvm_pkg::*;
    import seq_item_package::*;
    class scoreboard extends uvm_scoreboard;
        `uvm_component_utils(scoreboard);
        function new(string name="scoreboard",uvm_component parent =null);
            super.new(name,parent);
        endfunction //new()

        uvm_analysis_export #(seq_item) scoreboard_export;
        uvm_tlm_analysis_fifo #(seq_item) scoreboard_fifo;
        seq_item scoreboard_seq_item;

        int correct_count=0;
        int error_count=0;

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            scoreboard_export   =new("scoreboard_export",this);
            //scoreboard_seq_item =new("scoreboard_seq_item",this);
            scoreboard_fifo     =new("scoreboard_fifo",this);
            
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            scoreboard_export.connect(scoreboard_fifo.analysis_export);
            
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                scoreboard_fifo.get(scoreboard_seq_item);
                if (scoreboard_seq_item.out!=scoreboard_seq_item.out_golden_model) begin
                    `uvm_error("run_phase",$sformatf("comparison failed,transaction recieved by the DUT:%s", 
                    scoreboard_seq_item.convert2string()));     
                    error_count++;                   
                end
                else begin
                    //`uvm_info("run_phase",$sformatf("correct out_refput:%s ",scoreboard_seq_item.convert2string()),UVM_LOW);      
                     correct_count++; 
                end


            end


        endtask

        function void report_phase (uvm_phase phase); 
            super.report_phase(phase); 
            `uvm_info("report_phase",$sformatf("Total successful counts:%0d",correct_count),UVM_MEDIUM);      
            `uvm_info("report_phase",$sformatf("Total failed counts:%0d",error_count),UVM_MEDIUM);      
        endfunction 

    endclass 
endpackage
