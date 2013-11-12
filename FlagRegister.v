module FlagRegister(clk,rst,modify,inFlag,outFlag);

input clk,rst,modify;
input [2:0]inFlag;
output[2:0]outFlag;

reg [2:0]RegData;

always @(posedge clk)
begin
if(rst)
	RegData <= 0;
else if(modify)
  RegData <= inFlag;
end

assign outFlag = (modify)? inFlag:RegData;

endmodule
