module ALSU_Gold (ALSU_if.DUT_GOLD AL_if); 
    parameter  INPUT_PRIORIT="A"; 
    parameter  FULL_ADDER="ON"; 
    reg cin_reg,red_op_A_reg,red_op_B_reg,bypass_A_reg,bypass_B_reg,direction_reg,serial_in_reg; 
    reg [2:0] opcode_reg,A_reg,B_reg; 
    always @(posedge AL_if.clk or posedge AL_if.reset) begin 
      if(AL_if.reset) begin 
         cin_reg <= 0; 
         red_op_B_reg <= 0; 
         red_op_A_reg <= 0; 
         bypass_B_reg <= 0; 
         bypass_A_reg <= 0; 
         direction_reg <= 0; 
         serial_in_reg <= 0; 
         opcode_reg <= 0; 
         A_reg <= 0; 
         B_reg <= 0; 
      end else begin 
         cin_reg <= AL_if.cin; 
         red_op_B_reg <= AL_if.red_op_B; 
         red_op_A_reg <= AL_if.red_op_A; 
         bypass_B_reg <= AL_if.bypass_B; 
         bypass_A_reg <= AL_if.bypass_A; 
         direction_reg <= AL_if.direction; 
         serial_in_reg <= AL_if.serial_in; 
         opcode_reg <= AL_if.opcode; 
         A_reg <= AL_if.A; 
         B_reg <= AL_if.B; 
      end 
    end 
    always @(posedge AL_if.clk or posedge AL_if.reset) begin 
        if(AL_if.reset)begin 
          AL_if.out_golden_model<=6'h00; 
         AL_if.leds_golden_model<=16'h0000; 
        end 
        else begin 
            case (opcode_reg) 
         3'b000:begin 
            if (red_op_A_reg && red_op_B_reg) 
                  AL_if.out_golden_model<=|A_reg; 
                else if (red_op_A_reg)  
                  AL_if.out_golden_model <= |A_reg; 
                else if (red_op_B_reg) 
                  AL_if.out_golden_model<= |B_reg; 
                 else 
                  AL_if.out_golden_model<= A_reg|B_reg; 
                  if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
            end 
            else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
            end 
            else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
            end      
     end 
     3'b001:begin 
        if (red_op_A_reg && red_op_B_reg) 
              AL_if.out_golden_model<=^A_reg; 
            else if (red_op_A_reg)  
              AL_if.out_golden_model<= ^A_reg; 
            else if (red_op_B_reg) 
              AL_if.out_golden_model<= ^B_reg; 
             else 
              AL_if.out_golden_model<= A_reg^B_reg;  
 
         if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
            end 
            else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
            end 
            else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
            end            
     end 
     3'b010:begin 
        if (red_op_A_reg || red_op_B_reg)begin 
           AL_if.out_golden_model =0; 
           AL_if.leds_golden_model=~AL_if.leds_golden_model; 
        end 
         else if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
         end    
        else begin 
           AL_if.out_golden_model<=A_reg+B_reg+cin_reg;  
        end 
     end
     3'b011:begin 
        if (red_op_A_reg || red_op_B_reg) begin 
           AL_if.out_golden_model =0; 
           AL_if.leds_golden_model=~AL_if.leds_golden_model; 
        end 
         else if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
         end    
        else begin 
           AL_if.out_golden_model<=A_reg*B_reg;  
        end         
     end 
     3'b100:begin 
        if (red_op_A_reg || red_op_B_reg)begin 
           AL_if.out_golden_model =0; 
           AL_if.leds_golden_model=~AL_if.leds_golden_model; 
        end 
         else if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
         end    
        else begin 
            if (direction_reg) begin 
                AL_if.out_golden_model<={AL_if.out_golden_model[4:0],serial_in_reg}; 
            end 
            else 
                AL_if.out_golden_model<={serial_in_reg,AL_if.out_golden_model[5:1]}; 
        end         
     end 
     3'b101:begin 
        if (red_op_A_reg || red_op_B_reg)begin 
           AL_if.out_golden_model =0; 
           AL_if.leds_golden_model=~AL_if.leds_golden_model; 
        end 
         else if (bypass_A_reg && bypass_B_reg ) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_A_reg) begin 
            AL_if.out_golden_model<=A_reg; 
         end 
         else if (bypass_B_reg) begin 
            AL_if.out_golden_model<=B_reg; 
         end    
        else begin 
            if (direction_reg) begin 
                AL_if.out_golden_model<={AL_if.out_golden_model[4:0],AL_if.out_golden_model[5]}; 
            end 
            else 
                AL_if.out_golden_model<={AL_if.out_golden_model[0],AL_if.out_golden_model[5:1]}; 
        end    
     end 
     3'b110:begin 
        AL_if.out_golden_model =0; 
        AL_if.leds_golden_model=~AL_if.leds_golden_model; 
     end 
     3'b111:begin 
        AL_if.out_golden_model =0; 
        AL_if.leds_golden_model=~AL_if.leds_golden_model; 
     end                      
    endcase 
  end 
end 
endmodule //ALSU 
