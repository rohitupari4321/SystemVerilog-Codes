`define MON_IF vif.MONITOR.monitor_cb

class monitor;
  transaction trans;
  mailbox mon2scb;
  virtual intf vif;
  
  function new(virtual intf vif,mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main;
    forever begin
      trans = new();
      @(posedge vif.MONITOR.clk);
      @(posedge vif.MONITOR.clk);
      
      wait(`MON_IF.rd || `MON_IF.wr);
      trans.wr = `MON_IF.wr;
      trans.rd = `MON_IF.rd;
      trans.din = `MON_IF.din;
      
      @(posedge vif.MONITOR.clk);
      trans.dout = `MON_IF.dout;
      trans.empty = `MON_IF.empty;
      trans.full = `MON_IF.full;
      
      mon2scb.put(trans);
      trans.display("Monitor");
      
    end
  endtask
endclass