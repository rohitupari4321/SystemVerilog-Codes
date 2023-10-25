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
      
 /*     
//       @(posedge vif.MONITOR.clk);
//       @(posedge vif.MONITOR.clk);
//       trans.psel = `MON_IF.psel;
      wait(`MON_IF.psel);
      
//       @(posedge vif.MONITOR.clk);
//       @(posedge vif.MONITOR.clk);
//       trans.penable = `MON_IF.penable;
//       trans.pwrite = `MON_IF.pwrite;
      wait(`MON_IF.penable && `MON_IF.pwrite);
      
      trans.paddr = `MON_IF.paddr;
      trans.pwdata = `MON_IF.pwdata;
      
//       @(posedge vif.MONITOR.clk);
//       @(posedge vif.MONITOR.clk);
//       @(posedge vif.MONITOR.clk);
//       trans.penable = `MON_IF.penable;
      wait(!(`MON_IF.penable));
     
      
//       @(posedge vif.MONITOR.clk);
//       @(posedge vif.MONITOR.clk);
//       trans.penable = `MON_IF.penable; 
//       trans.pwrite = `MON_IF.pwrite;
       wait(`MON_IF.penable && !(`MON_IF.pwrite));
  */
      
      @(posedge vif.MONITOR.clk);
      @(posedge vif.MONITOR.clk);
      
      wait(`MON_IF.psel && `MON_IF.penable);
      trans.psel = `MON_IF.psel;
      trans.penable = `MON_IF.penable;
      trans.paddr = `MON_IF.paddr;
      
      if(`MON_IF.pwrite==1)
       begin
         trans.pwrite = `MON_IF.pwrite;
         trans.pwdata = `MON_IF.pwdata;
       end
      else
        begin
          trans.pwrite = `MON_IF.pwrite;
        end
   
      @(posedge vif.MONITOR.clk);
      @(posedge vif.MONITOR.clk);
      trans.pready = `MON_IF.pready;
      trans.pslverr = `MON_IF.pslverr;
      trans.prdata = `MON_IF.prdata;
      
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask
endclass