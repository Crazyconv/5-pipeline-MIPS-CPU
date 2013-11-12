module Reg_File(input [3:0]RAddr1, RAddr2, WAddr,
                input [15:0]WData,
                input  Wen,Clock,Reset,
                output [15:0]RData1,RData2);

reg [15:0]RegData[0:15];
integer i;

always @(posedge Clock)
begin
  if(Reset) begin 
    for(i=0;i<16;i=i+1) RegData[i] <= 0; end
  else
    RegData[WAddr] <= ((Wen==1)&&(WAddr!=0))? WData : RegData[WAddr]; 
end

assign RData1 = ((WAddr==RAddr1)&&(WAddr!= 0)&&(Wen==1))? WData : RegData[RAddr1];
assign RData2 = ((WAddr==RAddr2)&&(WAddr!= 0)&&(Wen==1))? WData : RegData[RAddr2];

endmodule