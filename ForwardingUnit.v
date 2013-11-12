`include "define.v"

module ForwardingUnit(input [`RSIZE-1:0]RAddr1, RAddr2, MEM_WAddr, WB_WAddr, 
                      input MEM_RFWen, WB_RFWen,
                      output reg MEM_EX_Fwd1, MEM_EX_Fwd2, WB_EX_Fwd1, WB_EX_Fwd2);

always @*
begin
  MEM_EX_Fwd1 = 0; 
  MEM_EX_Fwd2 = 0;
  WB_EX_Fwd1 = 0;
  WB_EX_Fwd2 = 0;
  if ((RAddr1==MEM_WAddr) && MEM_RFWen && (MEM_WAddr!=`RSIZE'd0)) MEM_EX_Fwd1 = 1;
  else if ((RAddr1==WB_WAddr) && WB_RFWen && (WB_WAddr!=`RSIZE'd0)) WB_EX_Fwd1 = 1;
  if ((RAddr2==MEM_WAddr) && MEM_RFWen && (MEM_WAddr!=`RSIZE'd0)) MEM_EX_Fwd2 = 1;
  else if ((RAddr2==WB_WAddr) && WB_RFWen && (WB_WAddr!=`RSIZE'd0)) WB_EX_Fwd2 = 1;
end

endmodule
 