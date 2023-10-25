
`define DRIV_IF vif.DRIVER.driver_cb

class driver;
	
	virtual intf vif;
	mailbox gen2driv;
	
	function new(virtual intf vif,mailbox gen2driv);
	this.vif = vif;
	this.gen2driv = gen2driv;
	endfunction
 
	task reset;
	wait(vif.rst);
	$display("Driver-reset Started");
	`DRIV_IF.data_in <= 0;
	wait(!vif.rst);
	$display("Driver-reset ended");
	endtask

	task drive;
	transaction trans;
	gen2driv.get(trans);

	@(posedge vif.DRIVER.clk);
	`DRIV_IF.data_in <= trans.data_in;
     trans.display("Driver");
	endtask
	
	task main;
	forever begin
	fork
	wait(vif.rst);
	forever	drive();
	join_any
	disable fork;
	end
	endtask
endclass



