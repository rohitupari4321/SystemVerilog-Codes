`include "interface.sv"
`include "test.sv"

module testbench();

	bit clk;
	bit rst;

	always #5 clk=~clk;

	initial begin
	rst=1;
	#10 rst=0;
	end

	intf vif(clk,rst);

	test TEST(vif);

     fifo DUT(
	.clk(vif.clk),
	.rst(vif.rst),
    .din(vif.din),
    .wr(vif.wr),
    .rd(vif.rd),
	.dout(vif.dout),
	.empty(vif.empty),
	.full(vif.full));

  	initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
