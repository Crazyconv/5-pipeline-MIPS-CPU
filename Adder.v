module Adder(input[15:0] offset,PC,
             output[15:0] tarPC);
             
assign tarPC = PC + offset;

endmodule