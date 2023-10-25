// Code your design here
// polonomial x^5 + x^2 + 1
// 100101 - 6 bit polynomial
module crc_parallel(
  input clk,rst,
  input [3:0]data,
  output  [4:0]crc_out
);

  reg [4:0] crc_reg,c;
  
  assign crc_out = crc_reg;
  
  always @(posedge clk) 
  begin
    c=5'b0;
    
    crc_reg[0] = c[1] ^ c[4] ^ data[0] ^ data[3];
    crc_reg[1] = c[2] ^ data[1];
    crc_reg[2] = c[3] ^ c[1] ^ c[4] ^ data[3] ^ data[2] ^ data[0];
    crc_reg[3] = c[4] ^ c[2] ^ data[1] ^ data[3];
    crc_reg[4] = c[0] ^ c[3] ^ data[2];
  end

  always @(posedge clk or posedge rst )
  begin
      if(rst)
        c <= 5'h0;
      else
        c <= crc_reg;
    end

  assign crc_out = c;

endmodule