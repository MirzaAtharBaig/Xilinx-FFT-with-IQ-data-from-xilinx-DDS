`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2019 04:02:38 PM
// Design Name: 
// Module Name: cntr
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


module counter_fft #(
parameter width = 14)
(
    input clk_cntr,
    output reg cntr_FFT_tlast
    );
    
    reg [width-1:0] cnt;
    always@(posedge clk_cntr)
    begin
    
              if(cnt==16383) begin
                   cnt <= 0;
                 cntr_FFT_tlast <= 1;
                         end     
            else  begin
            cnt <= cnt + 1;
            cntr_FFT_tlast<= 0;
                   end
    end
endmodule
