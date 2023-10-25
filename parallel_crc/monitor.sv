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
        trans.data_in = `MON_IF.data_in;
      
     	@(posedge vif.MONITOR.clk);
       trans.data_out = `MON_IF.data_out;
       
        mon2scb.put(trans);
     	trans.display("Monitor");
    end
	 
	endtask

endclass
	
