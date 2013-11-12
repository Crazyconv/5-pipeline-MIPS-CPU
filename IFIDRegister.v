module IFIDRegister(input clk, rst, stall, postflush, poststall,
                    input[15:0] inPC, inInstr,
                    output[15:0] outPC, outInstr);
reg [15:0]RegPC;
reg [15:0]RegInstr;

always @(posedge clk)
begin
  if(rst)
    begin
    RegPC <= 16'h0000;
    RegInstr <= 16'h4000;
    end
  else
    begin
    if(!stall)
      RegPC <= inPC;
    if(!poststall)
      RegInstr <= inInstr;
    end
end     

assign outPC = RegPC;
assign outInstr = (postflush)? 16'h4000 :
                 ((poststall)? RegInstr : inInstr);

endmodule
