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
    trans = new();
    forever begin
      repeat (2) @(posedge vif.MONITOR.clk);
      trans.din = vif.din;
      trans.dout = vif.dout;
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask
  
endclass