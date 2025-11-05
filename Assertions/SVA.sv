/*Module for assertions*/ 
module SVA (ALSU_if.DUT al_if); 
     
 
    property asser1; 
    @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h0)&&(al_if.red_op_A&&al_if.red_op_B&& ~al_if.bypass_A && ~al_if.bypass_B)) |-> ##2  (al_if.out==(|$past(al_if.A))); 
    endproperty 
 
    property asser2; 
    @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h0)&&(al_if.red_op_B&&~al_if.red_op_A&&~al_if.bypass_A&&~al_if.bypass_B)) |-> ##2  (al_if.out==(|$past(al_if.B,2))); 
    endproperty
    property asser3; 
        @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h1)&&(al_if.red_op_A&&al_if.red_op_B && !al_if.bypass_A && !al_if.bypass_B)) |-> ##2  (al_if.out==(^$past(al_if.A,2))); 
        endproperty 
     
        property asser4; 
        @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h1)&&(al_if.red_op_B && !al_if.red_op_A && !al_if.bypass_A && !al_if.bypass_B)) |-> ##2  (al_if.out==(^$past(al_if.B,2))); 
        endproperty 
     
        property asser5; 
        @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h2)&&((al_if.red_op_B)||(al_if.red_op_A))) |-> ##2  ((al_if.out==0)); 
        endproperty   
     
        property asser6; 
       @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h2)&&(~al_if.red_op_B && ~al_if.red_op_A && ~al_if.bypass_A && ~al_if.bypass_B)) |-> ##2  (al_if.out==($past(al_if.B,2)+$past(al_if.A,2)+$past(al_if.cin,2))); 
        endproperty     
     
        property asser7; 
        @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h3)&&(al_if.red_op_B || al_if.red_op_A)) |-> ##2  ((~al_if.out)&& (al_if.leds==~$past(al_if.leds))); 
        endproperty       
     
        property asser8; 
        @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h4)&&(al_if.red_op_B || al_if.red_op_A)) |-> ##2  ((~al_if.out) && (al_if.leds==~$past(al_if.leds))); 
        endproperty       
     
        property asser9; 
        @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h5)&&(al_if.red_op_B || al_if.red_op_A)) |-> ##2  ((~al_if.out) && (al_if.leds==~$past(al_if.leds))); 
        endproperty       
     
        property asser10; 
        @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h3)&&(~al_if.red_op_B && ~al_if.red_op_A)&& ~al_if.bypass_A && ~al_if.bypass_B) |-> ##2  (al_if.out==(($past(al_if.A,2))*($past(al_if.B,2)))); 
        endproperty 
          property asser11; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h4)&&~al_if.red_op_B && ~al_if.red_op_A&&al_if.direction && ~al_if.bypass_A  && ~al_if.bypass_B) |-> ##2  (al_if.out==({$past(al_if.out[4:0],1),$past(al_if.serial_in,2)})); 
    endproperty 
 
    property asser12; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h4)&&~al_if.red_op_B && ~al_if.red_op_A&&~al_if.direction&& ~al_if.bypass_A  && ~al_if.bypass_B) |-> ##2  (al_if.out==({$past(al_if.serial_in,2),$past(al_if.out[5:1],1)})); 
    endproperty    
 
    property asser13; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h5)&& (~al_if.red_op_B && ~al_if.red_op_A)&&(al_if.direction) && ~al_if.bypass_A  && ~al_if.bypass_B) |-> ##2  (al_if.out=={$past(al_if.out[4:0],1),$past(al_if.out[5],1)}); 
    endproperty        
     
    property asser14; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode==3'h5)&&(~al_if.red_op_B && ~al_if.red_op_A)&&(~al_if.direction) && ~al_if.bypass_A  && ~al_if.bypass_B) |-> ##2  (al_if.out=={$past(al_if.out[0],1),$past(al_if.out[5:1],1)}); 
    endproperty  
 
    property asser15; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode!=3'h6)&&(al_if.opcode!=3'h7)&&(~al_if.red_op_B && ~al_if.red_op_A)&&al_if.bypass_B && al_if.bypass_A) |-> ##2  (al_if.out==($past(al_if.A,2))); 
    endproperty  
     
    property asser16; 
    @(posedge al_if.clk) disable iff(al_if.reset)  ((al_if.opcode!=3'h6)&&(al_if.opcode!=3'h7)&& (~al_if.red_op_B && ~al_if.red_op_A)&&al_if.bypass_B && !al_if.bypass_A) |-> ##2  (al_if.out==($past(al_if.B,2))); 
    endproperty  
 
    property asser17; 
    @(negedge al_if.reset) al_if.reset  |-> ##2 (~al_if.out); 
    endproperty  
 
    property asser18; 
    @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h0)&&(~al_if.red_op_B&&~al_if.red_op_A&&~al_if.bypass_A&&~al_if.bypass_B)) |-> ##2  (al_if.out==($past(al_if.B,2))|($past(al_if.A,2))); 
    endproperty 
 
    property asser19; 
    @(posedge al_if.clk) disable iff(al_if.reset) ((al_if.opcode==3'h1)&&(~al_if.red_op_B&&~al_if.red_op_A&&~al_if.bypass_A&&~al_if.bypass_B)) |-> ##2  (al_if.out==($past(al_if.A,2))^($past(al_if.B,2))); 
    endproperty 
    
        as1:assert property (asser1) else $display("ERROR1");  
        as2:assert property (asser2) else $display("ERROR2"); 
        as3:assert property (asser3) else $display("ERROR3");  
        as4:assert property (asser4) else $display("ERROR4"); 
        as5:assert property (asser5) else $display("ERROR5"); 
        as6:assert property (asser6) else $display("ERROR6");  
        as7:assert property (asser7) else $display("ERROR7"); 
        as8:assert property (asser8) else $display("ERROR8"); 
        as9:assert property (asser9) else $display("ERROR9");  
        as10:assert property (asser10) else $display("ERROR10"); 
        as11:assert property (asser11) else $display("ERROR11"); 
        as12:assert property (asser12) else $display("ERROR12");  
        as13:assert property (asser13) else $display("ERROR13"); 
        as14:assert property (asser14) else $display("ERROR14"); 
        as15:assert property (asser15) else $display("ERROR15");  
        as16:assert property (asser16) else $display("ERROR16"); 
        as17:assert property (asser17) else $display("ERROR17"); 
        as18:assert property (asser18) else $display("ERROR18"); 
        as19:assert property (asser19) else $display("ERROR19"); 
     
        cv1:cover property (asser1); 
        cv2:cover property (asser2); 
        cv3:cover property (asser3); 
        cv4:cover property (asser4); 
        cv5:cover property (asser5); 
        cv6:cover property (asser6); 
        cv7:cover property (asser7); 
        cv8:cover property (asser8); 
        cv9:cover property (asser9); 
        cv10:cover property (asser10); 
        cv11:cover property (asser11); 
        cv12:cover property (asser12); 
        cv13:cover property (asser13); 
        cv14:cover property (asser14); 
        cv15:cover property (asser15); 
        cv16:cover property (asser16); 
        cv17:cover property (asser17); 
        cv18:cover property (asser18); 
        cv19:cover property (asser19); 
     
    endmodule    