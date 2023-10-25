// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"

module testbench();

	bit clk;
	bit rst;

	always #5 clk=~clk;

	initial begin
	rst=1;
	#5 rst=0;
	end

	intf vif(clk,rst);

	test TEST(vif);

   floating_point_unit DUT(
	.clk(vif.clk),
	.rst(vif.rst),
     .instruction(vif.instruction),
     .result(vif.result),
     .exception_flag(vif.exp_flag)
	);

  	initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
