`include "define.v"

module ALU(input [`DSIZE-1:0]A,B,
           input [2:0]op,
           input [3:0]imm,
           output reg [`DSIZE-1:0]Out,
           output reg [2:0]Flag); //Z V N

integer n;
  
always @*          // whenever the input signals change, the output changes                     
begin
  Flag = 0;
  case(op)        //use op to select among 8 operations
    3'b000:begin  //ADD
             Out = A + B;
             if(Out==`DSIZE'd0) Flag[2]=1;
             else if((Out[`DSIZE-1]==1 && A[`DSIZE-1]==0 && B[`DSIZE-1]==0) ||
                     (Out[`DSIZE-1]==0 && A[`DSIZE-1]==1 && B[`DSIZE-1]==1) ) Flag[1]=1;
             else if(Out[`DSIZE-1]==1) Flag[0]=1;
  		       end
    3'b001:begin  //SUB
             Out = A - B;
             if(Out==`DSIZE'd0) Flag[2]=1;
             else if((Out[`DSIZE-1]==1 && A[`DSIZE-1]==0 && B[`DSIZE-1]==1) ||
                     (Out[`DSIZE-1]==0 && A[`DSIZE-1]==1 && B[`DSIZE-1]==0) ) Flag[1]=1;
             else if(Out[`DSIZE-1]==1) Flag[0]=1;
  		       end               		
    3'b010:begin  //AND
             Out = A & B;
             if(Out==`DSIZE'd0) Flag[2]=1;
           end             		
    3'b011:begin  //OR
             Out = A | B;
             if(Out==`DSIZE'd0) Flag[2]=1;
           end
    3'b100:Out = A << imm;          		//SLL
    3'b101:Out = A >> imm;          		//SRL
    3'b110:Out = $signed(A) >>> imm;		//SRA
    3'b111:Out = A << imm | A >> 16-imm;  //RL
     
    default:Out = `DSIZE'd0;         //default
  endcase
  
//	if (Out==`DSIZE'd0) begin
//	Flag<=3'b100;
//	end if (Out<`DSIZE'd0)
//	begin
//	Flag<=3'b001;
//		if(A>`DSIZE'd0&& B>`DSIZE'd0&&Out<`DSIZE'd0) 
//		begin
//		Flag<=3'b011;
//		end 
//	end
//	if (Out>`DSIZE'd0)
//	begin
//	Flag<=3'b000;
//		if(A<`DSIZE'd0&& B<`DSIZE'd0&&Out>`DSIZE'd0) 
//		begin
//		Flag<=3'b010;
//		end
//	end

end
endmodule


