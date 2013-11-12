module Br_hzUnit(input Bran, EX_modify,
                 output stall);

assign stall = (Bran && EX_modify)? 1:0;

endmodule