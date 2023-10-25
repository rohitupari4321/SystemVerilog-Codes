`define DRIV_IF vif.DRIVER.driver_cb


class driver;
  transaction trans;
  mailbox gen2driv;
   virtual intf vif;	
  
  function new(virtual intf vif,mailbox gen2driv);
    this.vif=vif;
    this.gen2driv=gen2driv;
  endfunction
  
  task reset;
    wait(vif.rst);
    $display("Driver reset started");
    `DRIV_IF.din <= 0;
    wait(!vif.rst);
    $display("Driver reset ended");    
  endtask
  
   task main;
     forever begin
       gen2driv.get(trans);
       @(posedge vif.DRIVER.clk);
       `DRIV_IF.din <= trans.din;
       //@(posedge vif.clk);
       trans.dout = `DRIV_IF.dout;
       trans.display("Driver");
     end
      
    endtask
  
endclass
    
   