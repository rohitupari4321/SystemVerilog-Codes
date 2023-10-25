class monitor;
  
  transaction trans; 
  virtual intf vif;  
  mailbox mon2scb;   
  
  function new(virtual intf vif,mailbox mon2scb);
      this.vif = vif;
      this.mon2scb = mon2scb;
  endfunction
  
  task main();
    trans = new();      
    forever begin
      #2;
      trans.i = vif.i;    
      trans.s = vif.s;
      trans.y = vif.y;
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask
  
endclass
    
    