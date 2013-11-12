module PC(input clk, rst, stall,
          input [15:0]inPC,
          output [15:0]outPC);
reg [15:0]RegData;

always @(posedge clk)
begin
  if(rst)
    RegData <= 0;
  else if(!stall)
    RegData = inPC;
end  

assign outPC = RegData;

endmodule