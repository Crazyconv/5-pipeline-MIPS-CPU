module EXMEMRegister(input clk,rst,
                     input[15:0] inPC, inALUOut, inDWData, inimmedia,
                     input[3:0] inRFWAddr, inRAddr2, inopCode,
                     input[2:0] inFlag,
                     input[1:0] inRFWDataSc1,
                     input inRFWDataSc2, inDMWen, inEXE, inRFWen,
                     output[15:0] outPC, outALUOut, outDWData, outimmedia,
                     output[3:0] outRFWAddr, outRAddr2, outopCode,
                     output[2:0] outFlag, 
                     output[1:0] outRFWDataSc1,
                     output outRFWDataSc2, outDMWen, outEXE, outRFWen);

reg [84:0]RegData;

always @(posedge clk)
begin
  if(rst)
    RegData <= 0;
  else
    RegData <= {inPC, inALUOut, inDWData, inimmedia, inRFWAddr, inRAddr2, inFlag, inopCode, 
                inRFWDataSc1, inRFWDataSc2, inDMWen, inEXE, inRFWen}; 
end

assign outPC = RegData[84:69];
assign outALUOut = RegData[68:53]; 
assign outDWData = RegData[52:37]; 
assign outimmedia = RegData[36:21]; 
assign outRFWAddr = RegData[20:17];
assign outRAddr2 = RegData[16:13];
assign outFlag = RegData[12:10];
assign outopCode = RegData[9:6]; 
assign outRFWDataSc1 = RegData[5:4];
assign outRFWDataSc2 = RegData[3]; 
assign outDMWen = RegData[2]; 
assign outEXE = RegData[1]; 
assign outRFWen = RegData[0]; 

endmodule