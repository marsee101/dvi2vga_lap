//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: marsee101
// 
// Create Date: 2015/09/12 10:28:52
// Design Name: 
// Module Name: synchro
// Project Name: 
// Target Devices: 
// Tool Versions: Vivado 2015.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`default_nettype none

module synchro(
    input   wire    clk,
    input   wire    sync_in,
    output  wire    sync_out
    );
    
    reg ff0, ff1;
    
    always @(posedge clk) begin
        ff0 <= sync_in;
        ff1 <= ff0;
    end
    assign sync_out = ff1;
endmodule

`default_nettype wire
