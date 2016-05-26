// 0317001_0310511
module Lw_Hazard_Detection(
    rst,
    IF_ID_RS,
    IF_ID_RT,
    ID_EX_RT,
    ID_EX_memr,
    stall
    );

input        rst;
input  [4:0] IF_ID_RS;
input  [4:0] IF_ID_RT;
input  [4:0] ID_EX_RT;
input        ID_EX_memr;

output       stall;

assign stall = !rst && ID_EX_memr
    && ( (IF_ID_RS==ID_EX_RT && IF_ID_RS!=0) || 
         (IF_ID_RT==ID_EX_RT && IF_ID_RT!=0) );

endmodule   
