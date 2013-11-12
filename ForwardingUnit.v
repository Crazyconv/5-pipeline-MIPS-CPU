`include "define.v"

module ForwardingUnit(input [`RSIZE-1:0]RAddr1, RAddr2, MEM_RAddr2, MEM_WAddr, WB_WAddr, 
                      input MEM_RFWen, WB_RFWen,
                      input [3:0]MEM_opCode,
                      output reg MEM_EX_Fwd1, MEM_EX_Fwd2, WB_EX_Fwd1, WB_EX_Fwd2, WB_MEM_Fwd);

always @*
begin
  MEM_EX_Fwd1 = 0; 
  MEM_EX_Fwd2 = 0;
  WB_EX_Fwd1 = 0;
  WB_EX_Fwd2 = 0;
  WB_MEM_Fwd = 0;
  if ((RAddr1==MEM_WAddr) && MEM_RFWen && (MEM_WAddr!=`RSIZE'd0)) MEM_EX_Fwd1 = 1;
  else if ((RAddr1==WB_WAddr) && WB_RFWen && (WB_WAddr!=`RSIZE'd0)) WB_EX_Fwd1 = 1;
  if ((RAddr2==MEM_WAddr) && MEM_RFWen && (MEM_WAddr!=`RSIZE'd0)) MEM_EX_Fwd2 = 1;
  else if ((RAddr2==WB_WAddr) && WB_RFWen && (WB_WAddr!=`RSIZE'd0)) WB_EX_Fwd2 = 1;
  if ((MEM_opCode==4'd9) && (MEM_RAddr2==WB_WAddr) && WB_RFWen && (WB_WAddr!=`RSIZE'd0)) WB_MEM_Fwd = 1;
end

endmodule
 