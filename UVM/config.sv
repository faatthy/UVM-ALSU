`include "uvm_macros.svh" 
package config_package; 
    import uvm_pkg::*; 
    class config_object extends uvm_object; 
    `uvm_object_utils(config_object); 
     
    virtual ALSU_if config_vif; 
    uvm_active_passive_enum sel_mod; 
     
        function new (string name="config"); 
            super.new(name); 
        endfunction //new() 
     
    endclass //className     
    endpackage 
