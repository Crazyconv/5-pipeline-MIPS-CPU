`include "Branch.v"

module Branch_tb;

reg Bran;
reg [2:0] Cond,Flag; //Flag: Z V N

wire TakeBran;

BranchUnit branch(
		.Bran(Bran),
		.Cond(Cond),
		.Flag(Flag),
		
		.TakeBran(TakeBran)
		);

initial
begin
	Bran=0; Cond=3'd0 ; Flag= 3'd0;      //Initial State
                                        //output
#10  Bran=1; Cond=3'd0; Flag=3'b100;    //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd0; Flag=3'b000;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd0; Flag=3'b100;     //0
#2    $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd1; Flag=3'b000;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd1; Flag=3'b100;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd1; Flag=3'b000;     //0
#2    $display("%b",TakeBran);    

    $display("\n");
#8  Bran=1; Cond=3'd2; Flag=3'b000;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd2; Flag=3'b100;     //0
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd2; Flag=3'b001;     //0
#2    $display("%b",TakeBran);     
#8  Bran=0; Cond=3'd2; Flag=3'b000;     //0
#2    $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd3; Flag=3'b001;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd3; Flag=3'b000;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd3; Flag=3'b001;     //0
#2    $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd4; Flag=3'b100;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd4; Flag=3'b000;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd4; Flag=3'b001;     //0
#2    $display("%b",TakeBran);    
#8  Bran=0; Cond=3'd4; Flag=3'b100;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd4; Flag=3'b000;     //0
#2    $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd5; Flag=3'b100;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd5; Flag=3'b001;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd5; Flag=3'b000;     //0
#2   $display("%b",TakeBran);
#8  Bran=0; Cond=3'd5; Flag=3'b100;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd5; Flag=3'b001;     //0
#2    $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd6; Flag=3'b010;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd6; Flag=3'b000;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd6; Flag=3'b010;     //0
#2   $display("%b",TakeBran);

    $display("\n");
#8  Bran=1; Cond=3'd7; Flag=3'b000;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b001;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b010;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b011;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b100;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b101;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b110;     //1
#2    $display("%b",TakeBran);
#8  Bran=1; Cond=3'd7; Flag=3'b111;     //1
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd4; Flag=3'b000;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b000;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b001;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b010;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b011;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b100;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b101;     //0
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b110;
#2    $display("%b",TakeBran);
#8  Bran=0; Cond=3'd7; Flag=3'b111;     //0
#2   $display("%b",TakeBran);

//										 //Condition Code
//#8  Flag=3'b100;                         //000
//#8  Bran=1;                              
//#8  Cond=3'b001; Flag=3'b000;            //001
//#8  Bran=0;
//#8  Cond=3'b010;                         //010
//#8  Bran=1;
//#8  Cond=3'b011; Flag=3'b001;            //011
//#8  Bran=0;
//#8  Cond=3'b100; Flag=3'b100;            //100
//#8  Flag=3'b010;                          
//#8  Bran=1;
//#8  Cond=3'b101; Flag=3'b001;            //101
//#8  Flag=3'b100;
//#8  Bran=0;
//#8  Cond=3'b110; Flag=3'b010;            //110
//#8  Bran=1;
//#8  Cond=3'b111;                         //111
//#8  Bran=0;
#1000 $finish;
end

endmodule
