`define MON_IF vif.MONITOR.monitor_cb

class monitor;

  	transaction trans;
	virtual intf vif;
	mailbox mon2scb;

	function new(virtual intf vif,mailbox mon2scb);
	this.vif = vif;
	this.mon2scb = mon2scb;
	endfunction

	task main;
     forever begin
	 trans = new();
      
	 @(posedge vif.MONITOR.clk);
     @(posedge vif.MONITOR.clk);
      wait(!vif.rst);
      trans.instruction = `MON_IF.instruction;
      
     @(posedge vif.MONITOR.clk);
	  trans.result = `MON_IF.result;
      trans.exp_flag = `MON_IF.exp_flag;
      mon2scb.put(trans);
      trans.display("Monitor");
    end 
	endtask

endclass
	
