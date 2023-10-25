interface intf(input logic clk,rst);

  logic [31:0]instruction;	
  logic [31:0]result;
  logic exp_flag;

	
	clocking driver_cb @(posedge clk);
	default input #1 output #1;
	output instruction;	
	input result;	
	input exp_flag;	
	endclocking

	clocking monitor_cb @(posedge clk);	
	default input #1 output #1;
	input instruction;	
	input result;	
	input exp_flag;	
	endclocking

	modport DRIVER(clocking driver_cb,input clk,rst);
	modport MONITOR(clocking monitor_cb,input clk,rst);

endinterface
