`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

	// generator and driver instance
	generator gen;
	driver driv;
	monitor mon;
	scoreboard scb;

	//mailbox handle's
	mailbox gen2driv;
	mailbox mon2scb;

	// virtual interface
	virtual mem_intf mem_vif;

	//constructor
	function new(virtual mem_intf mem_vif);
	//get the interface from test
	this.mem_vif = mem_vif;

	// creating the mailbox (same handle will be shared across generator and driver)
	gen2driv = new();
	mon2scb = new();
	
	// creating generator and driver
	gen = new(gen2driv);
	driv = new(mem_vif,gen2driv);
	mon = new(mem_vif,mon2scb);
	scb = new(mon2scb);
      
    gen.next = scb.next;
 	endfunction

	task pre_test();
	driv.reset();
	endtask

	task test();
	fork
	gen.main();
	driv.main();
	mon.main();
	scb.main();
	join_any
	endtask

	task post_test();
      wait(gen.done.triggered);
	endtask

	// run task
	task run();
	pre_test();
	test();
	post_test();
	$finish;
	endtask

endclass