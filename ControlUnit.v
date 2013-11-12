module ControlUnit(opCode, EXE_pre, JAL, JR, RAddrSc, WAddrSc, BSc, immedSc, op, Bran, modify, EXE_cur, DMWen, RFWen, WDataSc1, WDataSc2);

input[3:0] opCode;
input EXE_pre;
output reg JAL,JR,Bran,RAddrSc,WAddrSc;
output reg [2:0] op;
output reg BSc,immedSc,modify,EXE_cur;
output reg DMWen;
output reg [1:0]WDataSc1;
output reg RFWen, WDataSc2;

always @*
begin
  JAL = 0;
  JR = 0;
  RAddrSc = 0;
  WAddrSc = 0;
  BSc = 0;
  immedSc = 0;
  op = 0;
  Bran = 0;
  modify = 0;
  EXE_cur = 0;
  DMWen = 0;
  RFWen = 0;
  WDataSc1 = 0;
  WDataSc2 = 0;
  case(opCode)
    //arithmetic operations
    4'b0000,4'b0001,4'b0010,4'b0011:  begin
      RAddrSc = 1;
      BSc = 1;
      op = opCode[2:0];
      modify = 1;
      RFWen = 1;  end
        
    //logic operations
    4'b0100,4'b0101,4'b0110,4'b0111:  begin
      op = opCode[2:0];
      RFWen = 1;  end
        
    //load from memory
    4'b1000:  begin
      RFWen = 1;
      WDataSc2 = 1;  end
      
    //store to memory
    4'b1001: 
      DMWen = 1;
      
    //LHB  
    4'b1010:  begin
      immedSc = 1;
      WDataSc1 = 2'b10;
      RFWen = 1;  end
      
    //LLB
    4'b1011:  begin
      WDataSc1 = 2'b10;
      RFWen = 1;  end
        
    //Branch instruction
    4'b1100:
      if(!EXE_pre) 
        Bran = 1;
        
    //Jump and Link
    4'b1101:  
      if(!EXE_pre) begin
        JAL = 1;
        WAddrSc = 1;
        WDataSc1 = 2'b11;
        RFWen = 1;  end
        
    //Jump register
    4'b1110:
      if(!EXE_pre)  
        JR = 1;
        
    //Exec
    4'b1111:  
      if(!EXE_pre) begin
        JR = 1;
        EXE_cur = 1;  end
    endcase 
end

endmodule
