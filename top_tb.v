module top_tb_file_io;

reg clk,rst;

top CPU(.clk(clk),.rst(rst));

always #5 clk = ~clk;

initial
  begin
    clk = 0;
    rst = 0;
#5 rst = 1;
#10 rst = 0;
    
#4000 $finish;
  end
  
endmodule
