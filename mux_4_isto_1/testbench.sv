`include "interface.sv"
`include "test.sv"

module testbench;
  
  intf i_intf();
  
  test t1(i_intf);
  
  mux41 h1(
    .i(i_intf.i),
    .s(i_intf.s),
    .y(i_intf.y)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
