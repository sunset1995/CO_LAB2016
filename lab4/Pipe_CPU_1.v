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

/**** ID stage ****/

//control signal

wire           ID_EX_mem_to_reg_i;
wire           ID_EX_reg_write_i;
wire           ID_EX_mem_to_reg_o;
wire           ID_EX_reg_write_o;
// WB stage

wire           ID_EX_mem_read_i;
wire           ID_EX_mem_write_i;
wire           ID_EX_branch_i;
wire           ID_EX_mem_read_o;
wire           ID_EX_mem_write_o;
wire           ID_EX_branch_o;
// MEM stage

wire   [3-1:0] ID_EX_alu_op_i;
wire           ID_EX_alu_src_i;
wire           ID_EX_reg_dst_i;
wire   [3-1:0] ID_EX_alu_op_o;
wire           ID_EX_alu_src_o;
wire           ID_EX_reg_dst_o;
// EX stage


wire [31:0] ID_EX_pc_4;
wire [31:0] ID_EX_read_data_1;
wire [31:0] ID_EX_read_data_2;
wire [31:0] ID_EX_sign_extend;
wire [4:0]  ID_EX_ins_up;
wire [4:0]  ID_EX_ins_down;




/**** EX stage ****/

//control signal



/**** MEM stage ****/
wire [ 4:0] EX_MEM_reg_rst_o;
wire [31:0] EX_MEM_write_data_o;
wire [31:0] EX_MEM_alu_result_o;
wire        EX_MEM_zero_o;
wire        EX_MEM_add_result_o;
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


/**** WB stage ****/
wire [ 4:0] MEM_WB_reg_dst_o;
wire [31:0] MEM_WB_alu_result_o;
wire [31:0] MEM_WB_read_data_o;
wire        MEM_WB_mem_to_reg_o;
wire        MEM_WB_reg_write_o;
wire        MEM_write_data_o;

/****************************************
Instnatiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0(
		.data0_i(IF_ID_pc_4_i),
        .data1_i(EX_MEM_add_result_o),
        .select_i(EX_MEM_zero_o & EX_MEM_branch_o),
        .data_o(pc_in_i)
        );

ProgramCounter PC(
        .clk_i(clk_i),      
        .rst_i (rst_i),     
        .pc_in_i(pc_in_i) ,   
        .pc_out_o(pc_out_o) 
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
        
Pipe_Reg #(.size(N)) IF_ID(       //N is the total length of input/output
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i({
                IF_ID_pc_4_i,
                IF_ID_im_i
                }),
        .data_o({
                IF_ID_pc_4_o,
                IF_ID_im_o
                })
        );
        
Reg_File RF(
        .clk_i(clk_i),      
        .rst_i(rst_i),     
        .RSaddr_i(IF_ID_im_o[25:21]) ,  
        .RTaddr_i(IF_ID_im_o[20:16]) ,  
        .RDaddr_i(MEM_WB_reg_dst_o), // WBstage  
        .RDdata_i(MEM_write_data_o), //WBstage
        .RegWrite_i (MEM_WB_reg_write_o), // WBstage
        .RSdata_o(ID_EX_read_data_1),  
        .RTdata_o(ID_EX_read_data_2)   
);

Decoder Control(
        .instr_op_i(IF_ID_im_o[31:26]), 
        .RegWrite_o(ID_EX_reg_write_i),
        .ALU_op_o(ID_EX_alu_op_i),   
        .ALUSrc_o(ID_EX_alu_src_i),   
        .RegDst_o(ID_EX_reg_dst_i),   
        .Branch_o(ID_EX_branch_i),
        .Jump_o(1'b0),
        .MemRead_o(ID_EX_mem_read_i),
        .MemWrite_o(ID_EX_mem_write_i),
        .MemtoReg_o(ID_EX_mem_to_reg_i),
        .Jal_o(1'b0)
        );

Sign_Extend Sign_Extend(
        .data_i(IF_ID_im_o[15:0]),
        .data_o(ID_EX_sign_extend)
        );  

Pipe_Reg #(.size(N)) ID_EX(
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
                ID_EX_reg_dst_i
                }),
        .data_o({
                ID_EX_mem_to_reg_o,
                ID_EX_reg_write_o,
                ID_EX_mem_read_o,
                ID_EX_mem_write_o,
                ID_EX_branch_o,
                ID_EX_alu_op_o,
                ID_EX_alu_src_o,
                ID_EX_reg_dst_o
                })

        );
        
//Instantiate the components in EX stage       
ALU ALU(
        .src1_i(RFD1_or_shamt),
        .src2_i(Src_data_o),
        .ctrl_i(ALUCtrl_o),
        .result_o(result_o),
        .zero_o(zero_o)
);
        
ALU_Control ALU_Control(
        .funct_i(IF_ID_im_o[5:0]),   
        .ALUOp_i(ID_EX_alu_op_i),   
        .ALUCtrl_o(ALUCtrl_o) 
);

MUX_2to1 #(.size(32)) Mux1(

        );
        
MUX_2to1 #(.size(5)) Mux2(

        );

Pipe_Reg #(.size(N)) EX_MEM(
        clk_i(clk_i),
        rst_i(rst_i),
        data_i({
            }),
        data_o({
            EX_MEM_reg_rst_o,
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
assign MEM_WB_reg_dst_i    = EX_MEM_reg_rst_o;
assign MEM_WB_alu_result_i = EX_MEM_alu_result_o;
assign EX_MEM_mem_to_reg_o = MEM_WB_mem_to_reg_i;
assign EX_MEM_reg_write_o  = MEM_WB_reg_write_i;
Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(EX_MEM_alu_result_o),
        .data_i(EX_MEM_write_data_o),
        .MemRead_i(EX_MEM_mem_read_o),
        .MemWrite_i(EX_MEM_mem_write_o),
        .data_o(MEM_WB_read_data_i)
        );

Pipe_Reg #(.size(N)) MEM_WB(
        clk_i(clk_i),
        rst_i(rst_i),
        data_i({
            MEM_WB_reg_dst_i,
            MEM_WB_alu_result_i,
            MEM_WB_read_data_i,
            MEM_WB_mem_to_reg_i,
            MEM_WB_reg_write_i
            }),
        data_o({
            MEM_WB_reg_dst_o,
            MEM_WB_alu_result_o,
            MEM_WB_read_data_o,
            MEM_WB_mem_to_reg_o,
            MEM_WB_reg_write_o
            })
        );

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux2(
        .data0_i(MEM_WB_alu_result_o),
        .data1_i(MEM_WB_read_data_o),
        .select_i(MEM_WB_mem_to_reg_o),
        .data_o(MEM_write_data_o)
        );

/****************************************
signal assignment
****************************************/   
endmodule

