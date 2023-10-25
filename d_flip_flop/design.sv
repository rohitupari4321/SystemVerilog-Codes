// Code your design here
module dff(
  input clk,rst,din,
  output reg dout
);
  
  always@(posedge clk)
    begin
      if(rst)
        dout <= 1'b0;
      else
        dout <= din;
    end
endmodule