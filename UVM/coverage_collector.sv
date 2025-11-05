`include "uvm_macros.svh"
package coverage_collector_package;

    import uvm_pkg::*;
    import seq_item_package::*;

    class coverage_collector extends uvm_component; 
        `uvm_component_utils(coverage_collector); 
        uvm_analysis_export #(seq_item) cov_analysis_export;
        uvm_tlm_analysis_fifo #(seq_item) cov_fifo;
        seq_item seq_item_cov;
covergroup cvr_gp;
    A_cp: coverpoint seq_item_cov.A {
        bins data_0           = {0};
        bins data_max         = {MAXPOS};
        bins data_min         = {MAXNEG};
        bins Data_walkingones = {3'b001,3'b010,3'b100};
        bins data_default     = default;
    }
    B_cp: coverpoint seq_item_cov.B {
        bins data_0           = {0};
        bins data_max         = {MAXPOS};
        bins data_min         = {MAXNEG};
        bins Data_walkingones = {3'b001,3'b010,3'b100};
        bins data_default     = default;
    }
    
    ALU_cp: coverpoint  seq_item_cov.opcode {
        bins Bins_shift[]={SHIFT,ROTATE};
        bins Bins_arith[]={ADD,MULT};
        bins Bins_bitwise[] = {OR,XOR};
        illegal_bins Bins_invalid ={INVALID_6,INVALID_7};
        bins Bins_trans = (0=>1=>2=>3=>4=>5); 
    }
    
    ALU_cross_A_B: cross A_cp,B_cp,ALU_cp{
        bins cross_ALU_a_b_bins = binsof(ALU_cp.Bins_arith) && binsof(A_cp) intersect {ZERO,MAXNEG,MAXPOS} && binsof (B_cp) intersect {ZERO,MAXNEG,MAXPOS};
    
    
        ignore_bins ignore_cross_ALU_a_b_bins =! binsof(ALU_cp.Bins_arith) && binsof(A_cp) intersect {ZERO,MAXNEG,MAXPOS} && binsof (B_cp) intersect {ZERO,MAXNEG,MAXPOS};
        ignore_bins ignore_trans_opcode = binsof(ALU_cp.Bins_trans) ; 
    }
    
    cin_cp : coverpoint seq_item_cov.cin {
        bins cin_c_bin ={0,1};
    }
    
    ALU_cross_cin : cross ALU_cp,cin_cp{
        bins cross_ALU_cin_bins = binsof(ALU_cp.Bins_arith) && binsof(cin_cp.cin_c_bin);
    
    
        ignore_bins  ignore_cross_ALU_cin_bins =! binsof(ALU_cp.Bins_arith) && binsof(cin_cp.cin_c_bin);
    
    }
    serial_in_cp : coverpoint seq_item_cov.serial_in{
        bins serial_in_bins ={0,1};
    }
    
    direction_cp : coverpoint seq_item_cov.direction {
        bins direction_bins ={0,1};
    
    }
    ALU_cross_serial_in_direction : cross ALU_cp,serial_in_cp,direction_cp{
        bins cross_ALU_serial_in_bins = binsof(ALU_cp) intersect {SHIFT} && binsof(serial_in_cp.serial_in_bins);
        bins cross_ALU_dirextion_bins = binsof(ALU_cp.Bins_shift) && binsof(direction_cp.direction_bins);
    
        ignore_bins ignore_cross_ALU_serial_in_bins = ! binsof(ALU_cp) intersect {SHIFT} && binsof(serial_in_cp.serial_in_bins);
        ignore_bins ignore_cross_ALU_dirextion_bins = ! binsof(ALU_cp.Bins_shift) && binsof(direction_cp.direction_bins);
    }
    
    red_B_cp : coverpoint seq_item_cov.red_op_B 
        { 
            bins Bins_red_B = {0,1}; 
        }  
    
    red_A_cp : coverpoint seq_item_cov.red_op_A 
        { 
            bins Bins_red_A = {0,1}; 
        }  
    
    ALU_cross: cross A_cp ,B_cp ,ALU_cp ,red_A_cp ,red_B_cp  
        { 
            bins cross_bitwise_redA = binsof(ALU_cp.Bins_bitwise) && binsof(red_A_cp.Bins_red_A[1])  
                                            && binsof(A_cp.Data_walkingones) && binsof(B_cp.data_0); 
     
            bins cross_bitwise_redB = binsof(ALU_cp.Bins_bitwise) && binsof(red_B_cp.Bins_red_B[1])  
                                            && binsof(B_cp.Data_walkingones) && binsof(A_cp.data_0); 
     
            // we will create ignore bins for all other default bins 
            ignore_bins ignore_bitwise1 = ! binsof(ALU_cp.Bins_bitwise) && binsof(red_A_cp.Bins_red_A[1])  
                                              && binsof(A_cp.Data_walkingones) && binsof(B_cp.data_0) ; 
     
            ignore_bins ignore_bitwise2 = ! binsof(ALU_cp.Bins_bitwise) && binsof(red_B_cp.Bins_red_B[1])  
                                              && binsof(B_cp.Data_walkingones) && binsof(A_cp.data_0) ; 
     
            // illegal bins for invalid cases 
           /* illegal_bins cross_red_A_not_bitwise = binsof(ALU_cp) intersect {ADD,MULT,SHIFT,ROTATE} && binsof(red_A_cp.Bins_red_A[1]); 
     
            illegal_bins cross_red_B_not_bitwise = binsof(ALU_cp) intersect {ADD,MULT,SHIFT,ROTATE} && binsof(red_B_cp.Bins_red_B[1]); */
        } 
    endgroup

    function new (string name="coverage_collector",uvm_component parent= null);

        super.new(name,parent);
        cvr_gp=new();
        
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_fifo=new("cov_fifo",this);
        cov_analysis_export=new("cov_analysis_export",this);
        
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_analysis_export.connect(cov_fifo.analysis_export);
        
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(seq_item_cov);
            cvr_gp.sample();
        end
    endtask
    endclass
endpackage
    
