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

always @(*) begin
    if(redo) begin
        out  <= last;
        last <= last; 
    end
    else begin
        out  <= in;
        last <= in;
    end
end

endmodule   
