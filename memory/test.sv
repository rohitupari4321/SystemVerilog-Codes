`include "environment.sv"
program test(mem_intf intf);

	environment env;
	
	initial begin
	env = new(intf);
	env.gen.count = 8;
	env.run();
	end
endprogram
