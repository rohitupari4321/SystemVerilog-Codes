
`define DRIV_IF vif.DRIVER.driver_cb

class driver;
	
  	transaction trans;
	virtual intf vif;
	mailbox gen2driv;
	
	function new(virtual intf vif,mailbox gen2driv);
	this.vif = vif;
	this.gen2driv = gen2driv;
	endfunction
 
	task reset;
	wait(vif.rst);
    $display("Driver-reset started");
    `DRIV_IF.instruction <= 0;
	wait(!vif.rst);
	$display("Driver-reset ended");
	endtask

	task drive;
	gen2driv.get(trans);
	@(posedge vif.DRIVER.clk);
	`DRIV_IF.instruction <= trans.instruction;
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



