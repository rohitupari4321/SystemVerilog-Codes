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
    test t1(vif);

        dff DUT(
          .clk(vif.clk),
          .rst(vif.rst),
          .din(vif.din),
          .dout(vif.dout));

	initial begin
		$dumpfile("dump.vcd"); $dumpvars;
	end
endmodule
