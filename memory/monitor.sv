
`define MON_IF mem_vif.MONITOR.monitor_cb

class monitor;

    transaction trans;
	virtual mem_intf mem_vif;
	mailbox mon2scb;

	function new(virtual mem_intf mem_vif,mailbox mon2scb);
	  this.mem_vif = mem_vif;
	  this.mon2scb = mon2scb;
	endfunction

	task main;
	forever begin
	trans = new();
	
	@(posedge mem_vif.MONITOR.clk);
    @(posedge mem_vif.MONITOR.clk);
      
	wait(`MON_IF.rd_en || `MON_IF.wr_en);
	trans.addr =  `MON_IF.addr;
	trans.wr_en = `MON_IF.wr_en;
	trans.wdata = `MON_IF.wdata;
	trans.rd_en = `MON_IF.rd_en;
      
	//@(posedge mem_vif.MONITOR.clk);
    @(posedge mem_vif.MONITOR.clk);
	trans.rdata = `MON_IF.rdata;
      
	mon2scb.put(trans);
    trans.display("Monitor");
	end
	endtask

endclass
	
