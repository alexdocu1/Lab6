`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 01:41:15 PM
// Design Name: 
// Module Name: final
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
module final(
input [3:0] a,b,
input ci,
input clk,en,
output [15:0] bcd_d_out,
output rdy
);

wire co;
wire [3:0]s;
cla uuu(.s(s), .co(co),.a(a),.b(b),.ci(ci));
wire [11:0] bin_d_in = {7'b0,co,s};
bin2BCD bbb(.bin_d_in(bin_d_in),.bcd_d_out(bcd_d_out),.rdy(rdy),.clk(clk),.en(en));





endmodule



module bin2BCD(

input clk,
input en,
input [11:0] bin_d_in,

output [15:0] bcd_d_out,
output rdy
);

//State variables
parameter IDLE = 3'b000;
parameter SETUP = 3'b001;
parameter ADD = 3'b010;
parameter SHIFT = 3'b011;
parameter DONE = 3'b100;

//reg [11:0] bin_data = 0;
reg [27:0] bcd_data = 0;
reg [2:0] state = 0;
reg busy = 0;
reg [3:0] sh_counter = 0;
reg [1:0] add_counter = 0;
reg result_rdy = 0;

always @(posedge clk)
begin
if(en)
begin
if(~busy)
begin
bcd_data <= {16'b0, bin_d_in};
state <= SETUP;
end

end

case(state)

IDLE:
begin
result_rdy <= 0;
busy <= 0;
end

SETUP:
begin
busy <= 1;
state <= ADD;
end

ADD:
begin

case(add_counter)
0:
begin
if(bcd_data[15:12] > 4)
begin
bcd_data[27:12] <= bcd_data[27:12] + 3;
end
add_counter <= add_counter + 1;
end

1:
begin
if(bcd_data[19:16] > 4)
begin
bcd_data[27:16] <= bcd_data[27:16] + 3;
end
add_counter <= add_counter + 1;
end

2:
begin
if((add_counter == 2) && (bcd_data[23:20] > 4))
begin
bcd_data[27:20] <= bcd_data[27:20] + 3;
end
add_counter <= add_counter + 1;
end

3:
begin
if((add_counter == 3) && (bcd_data[27:24] > 4))
begin
bcd_data[27:24] <= bcd_data[27:24] + 3;
end
add_counter <= 0;
state <= SHIFT;
end
endcase
end

SHIFT:
begin
sh_counter <= sh_counter + 1;
bcd_data <= bcd_data << 1;

if(sh_counter == 11)
begin
sh_counter <= 0;
state <= DONE;
end
else
begin
state <= ADD;
end

end

DONE:
begin
result_rdy <= 1;
state <= IDLE;
end
default:
begin
state <= IDLE;
end

endcase

end
assign bcd_d_out = bcd_data[27:12];
assign rdy = result_rdy;
endmodule

module cla(
input [3:0] a,
input [3:0] b,
input ci,
output reg [3:0] s,
output reg co

    );
    reg [3:0]p,g;
    reg [2:0]c;
    integer i;
    always @(*)
    begin
    p[0] = a[0] ^ b[0];
    g[0] = a[0] & b[0];
    s[0] = p[0] ^ ci;
    c[0] = (ci & p[0]) | g[0];
    p[1] = a[1] ^ b[1];
    g[1] = a[1] & b[1];
    s[1] = p[1] ^ c[0];
    c[1] = (c[0] & p[1]) | g[1];
    p[2] = a[2] ^ b[2];
    g[2] = a[2] & b[2];
    s[2] = p[2] ^ c[1];
    c[2] = (c[1] & p[2]) | g[2];
    p[3] = a[3] ^ b[3];
    g[3] = a[3] & b[3];
    s[3] = p[3] ^ c[2];
    co = (c[2] & p[3]) | g[3];
   end 
endmodule




