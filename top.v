`include "define.v"

module top(input clk,rst);

wire [`MEM_SPACE-1:0]PCnext;

wire [`MEM_SPACE-1:0]PCcur;              
wire [`ISIZE-1:0]IF_instruction;
wire [`MEM_SPACE-1:0]IF_PCnext;                        

wire [`ISIZE-1:0]ID_instruction;
wire [`MEM_SPACE-1:0]ID_PCnext;
wire [3:0]opCode;

//control signals
wire JAL, JR, Bran, RAddrSc, WAddrSc;
wire ID_EXE, ID_BSc, ID_immedSc, ID_modify;
wire [2:0]ID_op;
wire ID_DMWen, ID_RFWen, ID_WDataSc2;
wire [1:0] ID_WDataSc1;

wire MEM_ID_Fwd, WB_ID_Fwd;

wire [`RSIZE-1:0]ID_RAddr1, ID_RAddr2; 
wire [`DSIZE-1:0]ID_RData1, ID_RData2; 

wire [2:0]Cond;
wire TakeBran;

wire flush, postflush, stall, stall_D, stall_Br, stall_JR, poststall;

wire [15:0]offset;
wire [`MEM_SPACE-1:0]PC_BranJAL;
wire [`MEM_SPACE-1:0]PC_EXEBack; 
wire [`MEM_SPACE-1:0]PC_JREXE;

wire [3:0]ID_imm;
wire [7:0]ID_immed;
wire [`RSIZE-1:0]ID_WAddr;

wire [`MEM_SPACE-1:0]EX_PCnext;   
wire [`DSIZE-1:0]EX_RData1,EX_RData2;   
wire [3:0]EX_imm; 
wire [7:0]EX_immed;  
wire [`RSIZE-1:0]EX_WAddr, EX_RAddr1, EX_RAddr2;    
wire [2:0]EX_op;   
wire [1:0] EX_WDataSc1;   
wire EX_BSc, EX_immedSc, EX_modify, EX_DMWen, EX_EXE, EX_RFWen, EX_WDataSc2;   

wire MEM_EX_Fwd1; 
wire MEM_EX_Fwd2;
wire WB_EX_Fwd1;
wire WB_EX_Fwd2;

wire [`DSIZE-1:0]A, B;   

wire [`DSIZE-1:0]EX_ALUout;   
wire [2:0]inFlag;   

wire [2:0]EX_Flag;                          

wire [`DSIZE-1:0]EX_DWData;
wire [`DSIZE-1:0]EX_immediate;              

wire [`MEM_SPACE-1:0]MEM_PCnext;
wire [`DSIZE-1:0]MEM_ALUout;
wire [`DSIZE-1:0]MEM_DWData; 
wire [`DSIZE-1:0]MEM_immediate;
wire [`RSIZE-1:0]MEM_WAddr;
wire [2:0]MEM_Flag;
wire [1:0]MEM_WDataSc1;
wire MEM_DWen, MEM_RFWen, MEM_EXE, MEM_WDataSc2;                            
wire [`DSIZE-1:0]MEM_SrcData;           //where
wire [`DSIZE-1:0]DRData;
wire [`RSIZE-1:0]WB_WAddr;               
wire [`DSIZE-1:0]WB_SrcData, WB_WData;               
wire WB_RFWen, WB_WDataSc2; 

//IF stage
assign PC_JREXE = (WB_ID_Fwd)? WB_WData : 
                 ((MEM_ID_Fwd)? MEM_SrcData : ID_RData2);
assign PC_EXEBack = EX_PCnext;
assign BranJAL = TakeBran | JAL;
  //select the address of the next fetched instruction
assign PCnext = (EX_EXE)? PC_EXEBack : 
               ((JR)? PC_JREXE:
               ((BranJAL)? PC_BranJAL : IF_PCnext));
               
//ID stage
assign opCode = ID_instruction[15:12];
assign ID_RAddr1 = ID_instruction[7:4];
assign ID_RAddr2 = (RAddrSc)? ID_instruction[3:0]:ID_instruction[11:8];
assign Cond = ID_instruction[10:8];
assign offset = (TakeBran)? $signed(ID_instruction[7:0]):$signed(ID_instruction[11:0]);
assign ID_imm = ID_instruction[3:0];
assign ID_immed = ID_instruction[7:0];
assign ID_WAddr = (WAddrSc)? 4'd15:ID_instruction[11:8];
  //if jump, flush the instruction fetched.
assign flush = TakeBran | JR | JAL | ID_EXE;
assign stall = stall_D | stall_Br | stall_JR;

//EX stage
assign A = (WB_EX_Fwd1)? WB_WData : ((MEM_EX_Fwd1)? MEM_SrcData : EX_RData1);
assign EX_DWData = (WB_EX_Fwd2)? WB_WData : ((MEM_EX_Fwd2)? MEM_SrcData : EX_RData2);
assign B = (EX_BSc)? EX_DWData : $signed(EX_imm); 

//MEM stage
assign MEM_SrcData = (MEM_WDataSc1==2'b10)? MEM_immediate :
                    ((MEM_WDataSc1==2'b11)? MEM_PCnext : MEM_ALUout);

//WB stage
assign WB_WData = (WB_WDataSc2)? DRData : WB_SrcData;

// Module instantiations
PC pc(.clk(clk), .rst(rst), .stall(stall), .inPC(PCnext),
      .outPC(PCcur));

I_memory IM(.address(PCcur), .clk(clk), .rst(rst),
            .data_out(IF_instruction));
            
Adder AD(.offset(16'h0001), .PC(PCcur), 
         .tarPC(IF_PCnext));

IFIDRegister IIR(.clk(clk), .rst(rst), .stall(stall), .postflush(postflush), .poststall(poststall),
                 .inPC(IF_PCnext), .inInstr(IF_instruction),
                 .outPC(ID_PCnext), .outInstr(ID_instruction));

ControlUnit CU(.opCode(opCode), .EXE_pre(MEM_EXE),
               //output 
               .JAL(JAL), .JR(JR), .Bran(Bran), .RAddrSc(RAddrSc), .WAddrSc(WAddrSc),
               .EXE_cur(ID_EXE), .BSc(ID_BSc), .immedSc(ID_immedSc), .op(ID_op), .modify(ID_modify), 
               .DMWen(ID_DMWen), .WDataSc1(ID_WDataSc1), .WDataSc2(ID_WDataSc2),
               .RFWen(ID_RFWen));

JR_hz_fwUnit HFU(.ID_RAddr2(ID_RAddr2), .EX_WAddr(EX_WAddr), .MEM_WAddr(MEM_WAddr), .WB_WAddr(WB_WAddr),
              .JR(JR), .EX_RFWen(EX_RFWen), .MEM_RFWen(MEM_RFWen), .WB_RFWen(WB_RFWen), .MEM_WDataSc2(MEM_WDataSc2),
              .MEM_ID_Fwd(MEM_ID_Fwd), .WB_ID_Fwd(WB_ID_Fwd), .stall(stall_JR));
               
HazardDetectionUnit HDU(.opCode(opCode), .RAddr1(ID_RAddr1), .RAddr2(ID_RAddr2), .EX_WAddr(EX_WAddr),
                        .EX_WDataSc2(EX_WDataSc2), .EX_RFWen(EX_RFWen),
                        .stall(stall_D));
Br_hzUnit BHU(.Bran(Bran), .EX_modify(EX_modify),
              .stall(stall_Br));

Reg_File RF(.RAddr1(ID_RAddr1), .RAddr2(ID_RAddr2), .WAddr(WB_WAddr), .WData(WB_WData),
            .Wen(WB_RFWen), .Clock(clk), .Reset(rst),
            //output
            .RData1(ID_RData1), .RData2(ID_RData2));
            
BranchUnit BU(.Bran(Bran), .Cond(Cond), .Flag(MEM_Flag), 
              //output 
              .TakeBran(TakeBran));
              
Adder AD_JUMP(.offset(offset), .PC(ID_PCnext), 
              //output
              .tarPC(PC_BranJAL));

IDEXRegister IER(.clk(clk), .rst(rst), .stall(stall), .flush(flush),
                 .inPC(ID_PCnext), .inRFRData1(ID_RData1), .inRFRData2(ID_RData2),
                 .inimm(ID_imm), .inimmed(ID_immed),
                 .inRFWAddr(ID_WAddr), .inRFRAddr1(ID_RAddr1), .inRFRAddr2(ID_RAddr2),
                 .inALUop(ID_op), .inRFWDataSc1(ID_WDataSc1), .inRFWDataSc2(ID_WDataSc2), .inBSc(ID_BSc), .inimmedSc(ID_immedSc), 
                 .inmodify(ID_modify), .inDMWen(ID_DMWen), .inEXE(ID_EXE), .inRFWen(ID_RFWen),
                 //output
                 .postflush(postflush),
                 .outPC(EX_PCnext), .outRFRData1(EX_RData1), .outRFRData2((EX_RData2)),
                 .outimm(EX_imm), .outimmed(EX_immed),
                 .outRFWAddr(EX_WAddr), .outRFRAddr1(EX_RAddr1), .outRFRAddr2(EX_RAddr2),
                 .outALUop(EX_op), .outRFWDataSc1(EX_WDataSc1), .outRFWDataSc2(EX_WDataSc2), .outBSc(EX_BSc), .outimmedSc(EX_immedSc),
                 .outmodify(EX_modify), .outDMWen(EX_DMWen), .outEXE(EX_EXE), .outRFWen(EX_RFWen), .poststall(poststall));

ALU alu(.A(A), .B(B), .op(EX_op), .imm(EX_imm),
        .Out(EX_ALUout), .Flag(inFlag));

FlagRegister FR(.clk(clk), .rst(rst), .modify(EX_modify), .inFlag(inFlag), 
                .outFlag(EX_Flag));
                
ForwardingUnit FU(.RAddr1(EX_RAddr1), .RAddr2(EX_RAddr2), .MEM_WAddr(MEM_WAddr), .WB_WAddr(WB_WAddr),
                  .MEM_RFWen(MEM_RFWen), .WB_RFWen(WB_RFWen),
                  .MEM_EX_Fwd1(MEM_EX_Fwd1), .MEM_EX_Fwd2(MEM_EX_Fwd2), .WB_EX_Fwd1(WB_EX_Fwd1), .WB_EX_Fwd2(WB_EX_Fwd2));

Concat CC(.regData(EX_DWData), .immData(EX_immed), .immedSc(EX_immedSc),
       .outData(EX_immediate));
       
EXMEMRegister EMR(.clk(clk), .rst(rst),
                  .inPC(EX_PCnext), .inALUOut(EX_ALUout), .inDWData(EX_DWData), .inimmedia(EX_immediate),
                  .inRFWAddr(EX_WAddr), .inFlag(EX_Flag), .inRFWDataSc1(EX_WDataSc1), .inRFWDataSc2(EX_WDataSc2),
                  .inDMWen(EX_DMWen), .inEXE(EX_EXE), .inRFWen(EX_RFWen),
                  //output
                  .outPC(MEM_PCnext), .outALUOut(MEM_ALUout), .outDWData(MEM_DWData), .outimmedia(MEM_immediate),
                  .outRFWAddr(MEM_WAddr), .outFlag(MEM_Flag), .outRFWDataSc1(MEM_WDataSc1), .outRFWDataSc2(MEM_WDataSc2),
                  .outDMWen(MEM_DWen), .outEXE(MEM_EXE), .outRFWen(MEM_RFWen));

D_memory DM(.clk(clk), .rst(rst), .write_en(MEM_DWen),
            .address(MEM_ALUout), .data_in(MEM_DWData),
            .data_out(DRData));

MEMWBRegister MWR(.clk(clk), .rst(rst),
                  .inSrcData(MEM_SrcData), .inRFWAddr(MEM_WAddr),
                  .inRFWen(MEM_RFWen), .inWDataSc2(MEM_WDataSc2),
                  //output
                  .outSrcData(WB_SrcData), .outRFWAddr(WB_WAddr),
                  .outRFWen(WB_RFWen), .outWDataSc2(WB_WDataSc2));

endmodule
