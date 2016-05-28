// 0317001_0310511
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
        clk_i,
        rst_i
        );
parameter N = 300;
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/

//orignal wire
wire [31:0] pc_in_i;
wire [31:0] pc_out_o;

wire [31:0] IF_ID_pc_4_i;
wire [31:0] IF_ID_im_i;
wire [31:0] IF_ID_pc_4_o;
wire [31:0] IF_ID_im_o;

wire [31:0] IF_ID_pc_4_o_tmp;
wire [31:0] IF_ID_im_o_tmp;
wire [31:0] IF_pc;

/**** ID stage ****/

//control signal

wire           ID_EX_mem_to_reg_i_tmp;
wire           ID_EX_reg_write_i_tmp;
wire           ID_EX_mem_to_reg_i;
wire           ID_EX_reg_write_i;
wire           ID_EX_mem_to_reg_o;
wire           ID_EX_reg_write_o;
// WB stage

wire           ID_EX_mem_read_i_tmp;
wire           ID_EX_mem_write_i_tmp;
wire           ID_EX_branch_i_tmp;
wire           ID_EX_mem_read_i;
wire           ID_EX_mem_write_i;
wire           ID_EX_branch_i;
wire           ID_EX_mem_read_o;
wire           ID_EX_mem_write_o;
wire           ID_EX_branch_o;
// MEM stage

wire   [3-1:0] ID_EX_alu_op_i_tmp;
wire           ID_EX_alu_src_i_tmp;
wire           ID_EX_reg_dst_i_tmp;
wire   [3-1:0] ID_EX_alu_op_i;
wire           ID_EX_alu_src_i;
wire           ID_EX_reg_dst_i;
wire   [3-1:0] ID_EX_alu_op_o;
wire           ID_EX_alu_src_o;
wire           ID_EX_reg_dst_o;
// EX stage


wire [31:0] ID_EX_pc_4_i = IF_ID_pc_4_o;
wire [31:0] ID_EX_read_data_1_i;
wire [31:0] ID_EX_read_data_2_i;
wire [31:0] ID_EX_sign_extend_i;
wire [4:0]  ID_EX_ins_rs_i = IF_ID_im_o[25:21];
wire [4:0]  ID_EX_ins_up_i = IF_ID_im_o[20:16];
wire [4:0]  ID_EX_ins_down_i = IF_ID_im_o[15:11];
wire [5:0]  ID_EX_ins_op_i = IF_ID_im_o[31:26];
wire [31:0] ID_EX_pc_4_o;
wire [31:0] ID_EX_read_data_1_o;
wire [31:0] ID_EX_read_data_2_o;
wire [31:0] ID_EX_sign_extend_o;
wire [4:0]  ID_EX_ins_rs_o;
wire [4:0]  ID_EX_ins_up_o;
wire [4:0]  ID_EX_ins_down_o;
wire [5:0]  ID_EX_ins_op_o;

wire        ID_lw_stall;




/**** EX stage ****/

wire [31:0] EX_rs_data;
wire [31:0] EX_rt_data;
wire [ 1:0] EX_rs_pick;
wire [ 1:0] EX_rt_pick;

wire [ 4:0] EX_MEM_reg_dst_i;
wire [31:0] EX_MEM_write_data_i = EX_rt_data[31:0];
wire [31:0] EX_MEM_alu_result_i;
wire        EX_MEM_zero_i;
wire [31:0] EX_MEM_add_result_i;
wire        EX_MEM_branch_i;
wire        EX_MEM_mem_write_i;
wire        EX_MEM_mem_read_i;
wire        EX_MEM_mem_to_reg_i;
wire        EX_MEM_reg_write_i;
wire [31:0] EX_shift_left_2_o;

// MEM stage

//control signal
wire [31:0] EX_alu_src_1;
wire [31:0] EX_alu_src_2;
wire [3:0]  ALUCtrl_o;

/**** MEM stage ****/
wire [ 4:0] EX_MEM_reg_dst_o;
wire [31:0] EX_MEM_write_data_o;
wire [31:0] EX_MEM_alu_result_o;
wire        EX_MEM_zero_o;
wire [31:0] EX_MEM_add_result_o;
wire        EX_MEM_branch_o;
wire        EX_MEM_mem_write_o;
wire        EX_MEM_mem_read_o;
wire        EX_MEM_mem_to_reg_o;
wire        EX_MEM_reg_write_o;

wire [ 4:0] MEM_WB_reg_dst_i;
wire [31:0] MEM_WB_alu_result_i;
wire [31:0] MEM_WB_read_data_i;
wire        MEM_WB_mem_to_reg_i;
wire        MEM_WB_reg_write_i;

wire        MEM_branch_take = EX_MEM_zero_o && EX_MEM_branch_o;

/**** WB stage ****/
wire [ 4:0] MEM_WB_reg_dst_o;
wire [31:0] MEM_WB_alu_result_o;
wire [31:0] MEM_WB_read_data_o;
wire        MEM_WB_mem_to_reg_o;
wire        MEM_WB_reg_write_o;
wire [31:0] MEM_write_data_o;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0(
        .data0_i(IF_ID_pc_4_i),
        .data1_i(EX_MEM_add_result_o),
        .select_i(MEM_branch_take),
        .data_o(pc_in_i)
        );

ProgramCounter PC(
        .clk_i(clk_i),      
        .rst_i (rst_i),     
        .pc_in_i(pc_in_i) ,   
        .pc_out_o(IF_pc) 
);

Instr_Memory IM(
        .addr_i(pc_out_o),  
        .instr_o(IF_ID_im_i)    
);
            
Adder Add_pc(
        .src1_i(32'd4),     
        .src2_i(pc_out_o),     
        .sum_o(IF_ID_pc_4_i)    
);

Redo #(.size(32)) PC_redo(
    .redo(ID_lw_stall),
    .in(IF_pc),
    .out(pc_out_o)
    );

Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i({
            (MEM_branch_take)? 32'b0 : IF_ID_pc_4_i,
            (MEM_branch_take)? 32'b0 : IF_ID_im_i
            }),
        .data_o({
            IF_ID_pc_4_o_tmp,
            IF_ID_im_o_tmp
            })
        );

Redo #(.size(64)) IF_ID_redo(
    .redo(ID_lw_stall),
    .in({
        IF_ID_pc_4_o_tmp,
        IF_ID_im_o_tmp
        }),
    .out({
        IF_ID_pc_4_o,
        IF_ID_im_o
        })
    );

//Instantiate the components in ID stage 
Lw_Hazard_Detection lw_hazard(
    .rst(MEM_branch_take),
    .IF_ID_RS(IF_ID_im_o[25:21]),
    .IF_ID_RT(IF_ID_im_o[20:16]),
    .ID_EX_RT(ID_EX_ins_up_o),
    .ID_EX_memr(ID_EX_mem_read_o),
    .stall(ID_lw_stall)
    );

Reg_File RF(
        .clk_i(clk_i),      
        .rst_i(rst_i),     
        .RSaddr_i(IF_ID_im_o[25:21]) ,  
        .RTaddr_i(IF_ID_im_o[20:16]) ,  
        .RDaddr_i(MEM_WB_reg_dst_o), // WBstage  
        .RDdata_i(MEM_write_data_o), //WBstage
        .RegWrite_i (MEM_WB_reg_write_o), // WBstage
        .RSdata_o(ID_EX_read_data_1_i),  
        .RTdata_o(ID_EX_read_data_2_i)   
);

Decoder Control(
        .instr_op_i(IF_ID_im_o[31:26]), 
        .RegWrite_o(ID_EX_reg_write_i_tmp),
        .ALU_op_o(ID_EX_alu_op_i_tmp),   
        .ALUSrc_o(ID_EX_alu_src_i_tmp),   
        .RegDst_o(ID_EX_reg_dst_i_tmp),   
        .Branch_o(ID_EX_branch_i_tmp),
        .Jump_o(),
        .MemRead_o(ID_EX_mem_read_i_tmp),
        .MemWrite_o(ID_EX_mem_write_i_tmp),
        .MemtoReg_o(ID_EX_mem_to_reg_i_tmp),
        .Jal_o()
        );

Sign_Extend Sign_Extend(
        .data_i(IF_ID_im_o[15:0]),
        .data_o(ID_EX_sign_extend_i)
        );


assign ID_EX_mem_to_reg_i = ID_EX_mem_to_reg_i_tmp && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_reg_write_i  = ID_EX_reg_write_i_tmp  && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_mem_read_i   = ID_EX_mem_read_i_tmp   && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_mem_write_i  = ID_EX_mem_write_i_tmp  && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_branch_i     = ID_EX_branch_i_tmp     && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_alu_op_i[0]  = ID_EX_alu_op_i_tmp[0]  && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_alu_op_i[1]  = ID_EX_alu_op_i_tmp[1]  && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_alu_op_i[2]  = ID_EX_alu_op_i_tmp[2]  && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_alu_src_i    = ID_EX_alu_src_i_tmp    && !ID_lw_stall && !MEM_branch_take;
assign ID_EX_reg_dst_i    = ID_EX_reg_dst_i_tmp    && !ID_lw_stall && !MEM_branch_take;

Pipe_Reg #(.size(159)) ID_EX(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i({
                ID_EX_mem_to_reg_i,
                ID_EX_reg_write_i,
                ID_EX_mem_read_i,
                ID_EX_mem_write_i,
                ID_EX_branch_i,
                ID_EX_alu_op_i,
                ID_EX_alu_src_i,
                ID_EX_reg_dst_i,
                ID_EX_pc_4_i,
                ID_EX_read_data_1_i,
                ID_EX_read_data_2_i,
                ID_EX_sign_extend_i,
                ID_EX_ins_rs_i,
                ID_EX_ins_up_i,
                ID_EX_ins_down_i,
                ID_EX_ins_op_i
                }),
        .data_o({
                ID_EX_mem_to_reg_o,
                ID_EX_reg_write_o,
                ID_EX_mem_read_o,
                ID_EX_mem_write_o,
                ID_EX_branch_o,
                ID_EX_alu_op_o,
                ID_EX_alu_src_o,
                ID_EX_reg_dst_o,
                ID_EX_pc_4_o,
                ID_EX_read_data_1_o,
                ID_EX_read_data_2_o,
                ID_EX_sign_extend_o,
                ID_EX_ins_rs_o,
                ID_EX_ins_up_o,
                ID_EX_ins_down_o,
                ID_EX_ins_op_o
                })

        );
        
//Instantiate the components in EX stage       
ALU ALU(
        .src1_i(EX_alu_src_1),
        .src2_i(EX_alu_src_2),
        .ctrl_i(ALUCtrl_o),
        .result_o(EX_MEM_alu_result_i),
        .zero_o(EX_MEM_zero_i)
);
        
ALU_Ctrl ALU_Control(
        .funct_i(ID_EX_sign_extend_o[5:0]),   
        .ALUOp_i(ID_EX_alu_op_o),   
        .ALUCtrl_o(ALUCtrl_o) 
);

MUX_3to1 #(.size(32)) Mux_RT(
    .data0_i(ID_EX_read_data_2_o),
    .data1_i(EX_MEM_alu_result_o),
    .data2_i(MEM_write_data_o),
    .select_i(EX_rt_pick),
    .data_o(EX_rt_data)
    );

MUX_2to1 #(.size(32)) Mux1(
        .data0_i(EX_rt_data),
        .data1_i(ID_EX_sign_extend_o),
        .select_i(ID_EX_alu_src_o),
        .data_o(EX_alu_src_2)
        );
        
MUX_2to1 #(.size(5)) Mux2(
        .data0_i(ID_EX_ins_up_o),
        .data1_i(ID_EX_ins_down_o),
        .select_i(ID_EX_reg_dst_o),
        .data_o(EX_MEM_reg_dst_i)
        );

MUX_3to1 #(.size(32)) Mux_RS(
    .data0_i(ID_EX_read_data_1_o),
    .data1_i(EX_MEM_alu_result_o),
    .data2_i(MEM_write_data_o),
    .select_i(EX_rs_pick),
    .data_o(EX_rs_data)
    );

MUX_2to1 #(.size(32)) Mux_SRA(
        .data0_i(EX_rs_data),
        .data1_i({27'b0,ID_EX_sign_extend_o[10:6]}),
        .select_i({ID_EX_ins_op_o,ID_EX_sign_extend_o[5:0]}==3),
        .data_o(EX_alu_src_1)
        );

Forwarding forwarding(
    .RS_addr(ID_EX_ins_rs_o),
    .RT_addr(ID_EX_ins_up_o),
    .EX_MEM_wrte(EX_MEM_reg_write_o),
    .EX_MEM_addr(EX_MEM_reg_dst_o),
    .MEM_WB_wrte(MEM_WB_reg_write_o),
    .MEM_WB_addr(MEM_WB_reg_dst_o),
    .RS_pick(EX_rs_pick),
    .RT_pick(EX_rt_pick)
    );

Shift_Left_Two_32 Shifter(
        .data_i(ID_EX_sign_extend_o),
        .data_o(EX_shift_left_2_o)
);       

Adder Branch_pc(
        .src1_i(ID_EX_pc_4_o),     
        .src2_i(EX_shift_left_2_o),     
        .sum_o(EX_MEM_add_result_i)    
        );


assign EX_MEM_branch_i = ID_EX_branch_o && !MEM_branch_take;
assign EX_MEM_mem_write_i = ID_EX_mem_write_o && !MEM_branch_take;
assign EX_MEM_mem_read_i = ID_EX_mem_read_o && !MEM_branch_take;
assign EX_MEM_mem_to_reg_i = ID_EX_mem_to_reg_o && !MEM_branch_take;
assign EX_MEM_reg_write_i = ID_EX_reg_write_o && !MEM_branch_take;

Pipe_Reg #(.size(107)) EX_MEM(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i({
            EX_MEM_reg_dst_i,
            EX_MEM_write_data_i,
            EX_MEM_alu_result_i,
            EX_MEM_zero_i,
            EX_MEM_add_result_i,
            EX_MEM_branch_i,
            EX_MEM_mem_write_i,
            EX_MEM_mem_read_i,
            EX_MEM_mem_to_reg_i,
            EX_MEM_reg_write_i
            }),
        .data_o({
            EX_MEM_reg_dst_o,
            EX_MEM_write_data_o,
            EX_MEM_alu_result_o,
            EX_MEM_zero_o,
            EX_MEM_add_result_o,
            EX_MEM_branch_o,
            EX_MEM_mem_write_o,
            EX_MEM_mem_read_o,
            EX_MEM_mem_to_reg_o,
            EX_MEM_reg_write_o
            })
        );
               
//Instantiate the components in MEM stage
assign MEM_WB_reg_dst_i    = EX_MEM_reg_dst_o;
assign MEM_WB_alu_result_i = EX_MEM_alu_result_o;
assign MEM_WB_mem_to_reg_i = EX_MEM_mem_to_reg_o;
assign MEM_WB_reg_write_i  = EX_MEM_reg_write_o;
Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(EX_MEM_alu_result_o),
        .data_i(EX_MEM_write_data_o),
        .MemRead_i(EX_MEM_mem_read_o),
        .MemWrite_i(EX_MEM_mem_write_o),
        .data_o(MEM_WB_read_data_i)
        );

Pipe_Reg #(.size(71)) MEM_WB(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i({
            MEM_WB_reg_dst_i,
            MEM_WB_alu_result_i,
            MEM_WB_read_data_i,
            MEM_WB_mem_to_reg_i,
            MEM_WB_reg_write_i
            }),
        .data_o({
            MEM_WB_reg_dst_o,
            MEM_WB_alu_result_o,
            MEM_WB_read_data_o,
            MEM_WB_mem_to_reg_o,
            MEM_WB_reg_write_o
            })
        );

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux_last(
        .data0_i(MEM_WB_alu_result_o),
        .data1_i(MEM_WB_read_data_o),
        .select_i(MEM_WB_mem_to_reg_o),
        .data_o(MEM_write_data_o)
        );

/****************************************
signal assignment
****************************************/   
endmodule
