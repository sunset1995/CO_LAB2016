// 0317001_0310511

module Forwarding(
    RS_addr,
    RT_addr,
    EX_MEM_wrte,
    EX_MEM_addr,
    MEM_WB_wrte,
    MEM_WB_addr,
    RS_pick,
    RT_pick
    );

input [4:0] RS_addr;
input [4:0] RT_addr;
input       EX_MEM_wrte;
input [4:0] EX_MEM_addr;
input       MEM_WB_wrte;
input [4:0] MEM_WB_addr;
// 0 pick data from ID/EX
// 1 pick data from EX/MEM
// 2 pick data from MEM/WB
output reg [1:0] RS_pick;
output reg [1:0] RT_pick;

always @(*) begin
    // deal with rs
    if(MEM_WB_wrte && MEM_WB_addr!=0 && RS_addr==MEM_WB_addr)
        RS_pick <= 2;
    else if(EX_MEM_wrte && EX_MEM_addr!=0 && RS_addr==EX_MEM_addr)
        RS_pick <= 1;
    else
        RS_pick <= 0;

    // deal with rt
    if(MEM_WB_wrte && MEM_WB_addr!=0 && RT_addr==MEM_WB_addr)
        RT_pick <= 2;
    else if(EX_MEM_wrte && EX_MEM_addr!=0 && RT_addr==EX_MEM_addr)
        RT_pick <= 1;
    else
        RT_pick <= 0;
end

endmodule     





                    
                    
