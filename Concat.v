module Concat(input [15:0] regData,
	            input [7:0] immData,
	            input immedSc,
	            output [15:0] outData);
	
assign outData = immedSc ? {immData, regData[7:0]}: $signed(immData);

endmodule
