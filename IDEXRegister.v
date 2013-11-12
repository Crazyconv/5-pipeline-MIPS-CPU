module IDEXRegister(input clk,rst,stall,flush,
                    input[15:0] inPC, inRFRData1, inRFRData2,
                    input[3:0] inimm, inopCode,
                    input[7:0] inimmed,
                    input[3:0] inRFWAddr, inRFRAddr1, inRFRAddr2,
                    input[2:0] inALUop,
                    input[1:0] inRFWDataSc1,
                    input inRFWDataSc2, inBSc, inimmedSc, inmodify, inDMWen, inEXE, inRFWen,
                    
                    output postflush, 
                    output[15:0] outPC, outRFRData1, outRFRData2,
                    output[3:0] outimm, outopCode,
                    output[7:0] outimmed,
                    output[3:0] outRFWAddr, outRFRAddr1, outRFRAddr2,
                    output[2:0] outALUop,
                    output[1:0] outRFWDataSc1,
                    output outRFWDataSc2, outBSc, outimmedSc, outmodify, outDMWen, outEXE, outRFWen, poststall);

reg [89:0]RegData;

always @(posedge clk)
begin
  if(rst)
    RegData <= 89'd0;
  else if(stall)
    RegData <= 89'd1;
  else
    RegData <= {flush,
                inPC,inRFRData1,inRFRData2,inimm,inopCode,inimmed,
                inRFWAddr,
                inRFRAddr1,inRFRAddr2,
                inALUop,inRFWDataSc1,inRFWDataSc2,inBSc,inimmedSc,inmodify,inDMWen,inEXE,inRFWen,stall};
end

assign postflush = RegData[89];
assign outPC = RegData[88:73]; 
assign outRFRData1 = RegData[72:57]; 
assign outRFRData2 = RegData[56:41];
assign outimm = RegData[40:37];
assign outopCode = RegData[36:33];
assign outimmed = RegData[32:25];
assign outRFWAddr = RegData[24:21]; 
assign outRFRAddr1 = RegData[20:17]; 
assign outRFRAddr2 = RegData[16:13];
assign outALUop = RegData[12:10];
assign outRFWDataSc1 = RegData[9:8];
assign outRFWDataSc2 = RegData[7];
assign outBSc = RegData[6]; 
assign outimmedSc = RegData[5]; 
assign outmodify = RegData[4]; 
assign outDMWen = RegData[3]; 
assign outEXE = RegData[2]; 
assign outRFWen = RegData[1];
assign poststall = RegData[0];

endmodule    
