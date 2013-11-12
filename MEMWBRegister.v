module MEMWBRegister(input clk,rst,
                     input [15:0]inSrcData,
                     input [3:0]inRFWAddr,
                     input inRFWen, inWDataSc2,
                     output [15:0]outSrcData,
                     output [3:0]outRFWAddr,
                     output outRFWen, outWDataSc2);

reg [21:0]RegData;

always @(posedge clk)
begin
  if(rst)
    RegData <= 0;
  else
    RegData <= {inSrcData, inRFWAddr, inRFWen, inWDataSc2}; 
end

assign outSrcData = RegData[21:6];
assign outRFWAddr = RegData[5:2];
assign outRFWen = RegData[1];
assign outWDataSc2 = RegData[0];

endmodule