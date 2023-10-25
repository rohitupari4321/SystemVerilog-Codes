
`include "interface.sv"
`include "test.sv"

module testbench;

  bit clk;
  bit rst;

 always #5 clk=~clk;

  initial begin
   rst=1;
   //#10 
    repeat(2) @(posedge clk);
    rst=0; 
  end

  intf i_intf(clk,rst);

  test t1(i_intf);

  crc_transmitter d1(
       .enable(i_intf.enb),
       .clk(i_intf.clk),
       .rstn(i_intf.rst),
       .crc_in(i_intf.data_in),
       .crc_out(i_intf.crc)
     );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule