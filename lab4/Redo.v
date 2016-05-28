// 0317001_0310511
module Redo(
    redo,
    in,
    out
    );

parameter size = 0;

input             redo;
input  [size-1:0] in;
output [size-1:0] out;

reg    [size-1:0] last;

assign out = (redo)? last : in;

always @(*) begin
    if(redo)
        last <= last; 
    else
        last <= in;
end

endmodule   
