interface intf(input logic clk,rst);

  logic [3:0]data_in;	
  logic [4:0]data_out;

	
	clocking driver_cb @(posedge clk);
	default input #1 output #1;
	output data_in;	
	input data_out;		
	endclocking

	clocking monitor_cb @(posedge clk);	
	default input #1 output #1;
	input data_in;	
	input data_out;		
	endclocking

	modport DRIVER(clocking driver_cb,input clk,rst);
	modport MONITOR(clocking monitor_cb,input clk,rst);

endinterface
