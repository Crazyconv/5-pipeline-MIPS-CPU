module ALUnFlag(input [15:0]A,B,
                input [2:0]op,
                input [3:0]imm,
                input clk, rst, modify,
                output[2:0]outFlag); //Z V N

wire[2:0] ALUFlag;

ALU alu(.A(A), .B(B), .op(op), .imm(imm), .Flag(ALUFlag));
FlagRegister FR(.clk(clk), .rst(rst), .modify(modify), .inFlag(ALUFlag), .outFlag(outFlag));

endmodule