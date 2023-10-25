`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 02:14:42 PM
// Design Name: 
// Module Name: final_tb
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


module final_tb();
reg [3:0] a,b;
reg ci;
reg clk = 0;
reg en;// = 0;
wire rdy;
wire [15:0] bcd_d_out;
final uut(.a(a),.b(b),.ci(ci),.rdy(rdy),.bcd_d_out(bcd_d_out),.clk(clk),.en(en));
initial
begin
//clk = 0;
forever
begin
#10 clk = ~clk; //10*2 for full wave
end
end

initial
begin
//forever
//begin
a= 5; b = 9; ci=1;
en = 1;
#20 //en must catch rising edge of clk
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a= 2; b=5; ci=0;
en = 1;
#20
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a=10 ; b=5; ci=0;
en = 1;
#20
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a= 15; b=15; ci=1;
en = 1;
#20
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a= 5; b=1; ci=1;
en = 1;
#20
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a= 11; b=10; ci=0;
en = 1;
#20
en = 0;
#620; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4); enableback to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

a= 12; b=15; ci=0;
en = 1;

#20
en = 0;
#1340; //IDEL (+1); SETUP (+1); ADD (+12*4); SHIFT (+12); DONE (+1); extra for edge case (+4);enable back to zero (-1) ~~> ((1+1+(12*4)+12+1+1+4-1)*10*2) = 1340

$finish;
//end
end


endmodule
