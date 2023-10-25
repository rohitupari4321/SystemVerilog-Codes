class monitor;
  
  transaction trans; // handle of transaction class
  virtual intf vif;  // virtual interface declaration
  mailbox mon2scb;   // declaration of the mailbox
  
  function new(virtual intf vif,mailbox mon2scb);
      this.vif = vif;
      this.mon2scb = mon2scb;
  endfunction
  
  task main();
    trans = new();      // constructor or creating object for class
    forever begin
      #2;
      trans.a = vif.a;    // sampling of data in monitor
      trans.b = vif.b;
      trans.sum = vif.sum;
      trans.carry = vif.carry;
      mon2scb.put(trans);
      trans.display("Monitor");
    end
  endtask
  
endclass
    
    