module EXMEMRegister(input clk,rst,
                     input[15:0] inPC, inALUOut, inDWData, inimmedia,
                     input[3:0] inRFWAddr,
                     input[2:0] inFlag,
                     input[1:0] inRFWDataSc1,
                     input inRFWDataSc2, inDMWen, inEXE, inRFWen,
                     output[15:0] outPC, outALUOut, outDWData, outimmedia,
                     output[3:0] outRFWAddr,
                     output[2:0] outFlag,
                     output[1:0] outRFWDataSc1,
                     output outRFWDataSc2, outDMWen, outEXE, outRFWen);

reg [76:0]RegData;

always @(posedge clk)
begin
  if(rst)
    RegData <= 0;
  else
    RegData <= {inPC, inALUOut, inDWData, inimmedia, inRFWAddr, inFlag, inRFWDataSc1, inRFWDataSc2, inDMWen, inEXE, inRFWen}; 
end

assign outPC = RegData[76:61];
assign outALUOut = RegData[60:45]; 
assign outDWData = RegData[44:29]; 
assign outimmedia = RegData[28:13]; 
assign outRFWAddr = RegData[12:9];
assign outFlag = RegData[8:6]; 
assign outRFWDataSc1 = RegData[5:4];
assign outRFWDataSc2 = RegData[3]; 
assign outDMWen = RegData[2]; 
assign outEXE = RegData[1]; 
assign outRFWen = RegData[0]; 

endmodule