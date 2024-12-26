`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2024 11:51:46 AM
// Design Name: 
// Module Name: 
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////
module automatic_washing_machine(clk, reset, door_closed,start,
water_level_decrease,detergent_quantity_decrease,cycle_time_out,
drained,spin_time_out,out );


   input clk, reset,start,door_closed,water_level_decrease,
   detergent_quantity_decrease,cycle_time_out,drained,spin_time_out;
    output reg [2:0]out;
    /* door_lock=        3'b001;
       water_volve_on=   3'b010;
      detergent_volve_on=3'b011;
      motor_on=          3'b100;
      drain_volve_on=    3'b101;
      done=              3'b110;
      */
    
  reg[2:0] pr_state,nxt_state;
  
  parameter      check_door =3'b000,
                  fill_water=3'b001,
                    detergent=3'b010,
                        cycle=3'b011,
                    drain_water=3'b100,
                      dry_spin=3'b101;
  /////////////////////////////
  always@(posedge clk)
  if(reset) begin
  pr_state<=check_door;
  out <= 3'b000; 
  end 
  else
  pr_state<=nxt_state;
  ////////////////////////////
  always@(start,door_closed,water_level_decrease,
   detergent_quantity_decrease,cycle_time_out,drained,spin_time_out,pr_state)
   case(pr_state)
check_door: begin
        if(start==1 && door_closed==1)
        begin 
        nxt_state=fill_water;
        out=3'b001;  //door_lock=1
        end
        else
        begin
        nxt_state= check_door;
        out=3'b000;
        end
         end
         
         
fill_water:begin
          if(water_level_decrease==0 && detergent_quantity_decrease ==1)
          begin
          nxt_state=detergent;
         out=3'b000;
         end
         else if(water_level_decrease==0 && detergent_quantity_decrease ==0)
        begin
          nxt_state=cycle;
         out=3'b000;
         end
         else
         begin
          nxt_state=fill_water;
         out=3'b010;   //water_volve_on=1
         end
         end
         
         
         
detergent:begin
          if(detergent_quantity_decrease ==1)
          begin
          nxt_state=detergent;
          out=3'b011;  //detergent_volve_on=1
          end
          else begin
          nxt_state=cycle;
          out=3'b000;  //detergent_volve_on=0
          end 
          end
          
          
cycle:begin
       if(cycle_time_out==1)
       begin
       nxt_state=drain_water;
          out=3'b000;  
      end
      else 
      begin
       nxt_state=cycle;
          out=3'b100;      //motor_on=1       
      end
      end
      
      
drain_water:begin
            if(water_level_decrease==1)
            begin
            nxt_state=fill_water;
            out=3'b000;
            end
            else if(detergent_quantity_decrease ==1)
            begin 
             nxt_state=detergent;
             out=3'b000;
             end
             else if(drained==1)
             begin
             nxt_state=dry_spin;
             out= 3'b101;   //drain_volve_on=1
             end
            else begin
            nxt_state=drain_water;
             out= 3'b000;
             end 
             end
             
             
             
             
dry_spin: begin
        if(spin_time_out==1)
        begin
             nxt_state=check_door;
             out= 3'b110;  //done= 1             
             end
            else begin
            nxt_state=dry_spin;
             out= 3'b000;
             end 
              end
              
              
default: begin 
         nxt_state=check_door; 
         out=3'b000;
         end
              
endcase
    
endmodule
