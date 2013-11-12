module BranchUnit(input Bran,
                  input[2:0] Cond,Flag, 
                  output reg TakeBran);
                  
wire N,V,Z;
assign Z = Flag[2];
assign V = Flag[1];
assign N = Flag[0];
  
always @*
begin
  TakeBran = 0;
  if(Bran)
    begin
    case(Cond)
      3'b000: if(Z==1) TakeBran = 1;
      3'b001: if(Z==0) TakeBran = 1;
      3'b010: if(Z==0 && N==0) TakeBran = 1;
      3'b011: if(N==1) TakeBran = 1;
      3'b100: if(Z==1 || (Z==0 && N==0)) TakeBran = 1;
      3'b101: if(Z==1 || N==1) TakeBran = 1;
      3'b110: if(V==1) TakeBran = 1;
      3'b111: TakeBran = 1;
      default: TakeBran = 0;
    endcase
    end
end
  
endmodule
