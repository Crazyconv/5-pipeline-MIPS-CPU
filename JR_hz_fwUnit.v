`include "define.v"

module JR_hz_fwUnit(input [`RSIZE-1:0]ID_RAddr2, EX_WAddr, MEM_WAddr,
                    input JR, EX_RFWen, MEM_RFWen, MEM_WDataSc2,
                    output reg MEM_ID_Fwd, stall);

always @*
begin
  MEM_ID_Fwd = 0; 
  stall = 0;
  if(JR)
    begin
      if((ID_RAddr2 == EX_WAddr) && (EX_WAddr != 0) && EX_RFWen)  stall = 1;
      else 
        if((ID_RAddr2 == MEM_WAddr) && (MEM_WAddr != 0) && MEM_RFWen)
          if(MEM_WDataSc2 == 1)  stall = 1;
          else  MEM_ID_Fwd = 1;
    end
end
  
  
endmodule
