`include "environment.sv"

program test(intf vif);

	environment env;
	
	initial begin
	env = new(vif);
	env.gen.count = 15;
	env.run();
	end
endprogram
