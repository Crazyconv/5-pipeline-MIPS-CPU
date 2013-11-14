`include "ALU.v"
`include "FlagRegister.v"

module ALUnFlag_tb;

reg [15:0]A,B;
reg [2:0]op;
reg [3:0]imm;
reg clk,rst;
reg modify;

wire [2:0]Flag;

ALUnFlag ini(.A(A), .B(B), .op(op), .imm(imm), .clk(clk), .rst(rst), .modify(modify), .outFlag(Flag));
			
always #5 clk = ~clk;
			
initial
begin
	   clk=0; rst=0; A=0; B=0; op=0; imm=0; modify=0;
#5   rst=1;
#10  rst=0;

   modify=1;
#10   A=16'hffff;     B=16'h0000;     op=3'd2;               //AND zero                  100
#2   $display("%b",Flag);
#8   A=16'hffff;     B=16'hffff;     op=3'd2;               //AND negative              000
#2   $display("%b",Flag);
#8   A=16'h0000;     B=16'h0000;     op=3'd3;               //OR  zero                  100
#2     $display("%b",Flag);
#8  A=16'hffff;     B=16'hffff;     op=3'd3;               //OR  negative              000
#2     $display("%b",Flag);
#8  A=16'h0001;     B=16'hffff;     op=3'd0;               //ADD zero                  100
#2     $display("%b",Flag);
#8  A=16'hfffe;     B=16'h0001;     op=3'd0;               //ADD negative              001
#2    $display("%b",Flag);
#8  A=16'h8001;     B=16'h8001;     op=3'd0;               //ADD overflow              010
#2     $display("%b",Flag);
#8  A=16'h7fff;     B=16'h7fff;     op=3'd0;               //ADD negative and overflow 010
#2     $display("%b",Flag);
#8  A=16'h0001;     B=16'h0001;     op=3'd1;               //SUB zero                  100
#2     $display("%b",Flag);
#8  A=16'h0000;     B=16'h0001;     op=3'd1;               //SUB negative              001
#2     $display("%b",Flag);
#8  A=16'h8000;     B=16'h0fff;     op=3'd1;               //SUB overflow              010
#2     $display("%b",Flag);
#8  A=16'h0fff;     B=16'h8000;     op=3'd1;               //SUB negative and overflow 010
#2     $display("%b",Flag);
     
//#10  A=16'h2E;       B=16'h16;       op=3'd2;               //AND
//#10  A=16'h34;       B=16'h26;       op=3'd3;               //OR
//#10  A=16'd10;       B=16'd14;       op=3'd4; imm=4'd4;     //SLL   
//#10  A=16'd11;       B=16'd14;       op=3'd5; imm=4'd3;     //SRL
//#10  A=16'd60;       B=16'd14;       op=3'd6; imm=4'd2;     //SRA with positive number
//#10  A=16'hF000;     B=16'd14;       op=3'd6; imm=4'd2;     //SRA with negative number
//#10  A=16'hF000;     B=16'd14;       op=3'd7; imm=4'd1;     //RL

#10    modify=0;
#10     A=16'h000a;     imm=4'd4;       op=3'd4;               //SLL                       010   
#2     $display("%b",Flag);
#8  A=16'h000b;     imm=4'd3;       op=3'd5;               //SRL                       010
#2     $display("%b",Flag);
#8  A=16'h003c;     imm=4'd2;       op=3'd6;               //SRA                       010
#2     $display("%b",Flag);
#8  A=16'hf000;     imm=4'd1;       op=3'd7;               //RL                        010
#2     $display("%b",Flag);

#10  $finish;
end

endmodule