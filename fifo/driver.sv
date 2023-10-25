`define DRIV_IF vif.DRIVER.driver_cb

class driver;
  
  transaction trans;
  mailbox gen2driv;
  virtual intf vif;
  
  function new(virtual intf vif,mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset;
    wait(vif.rst);
    $display("Driver reset started");
    `DRIV_IF.din <= 0;
    `DRIV_IF.wr <= 0;
    `DRIV_IF.rd <= 0;
    wait(!vif.rst);
    $display("Driver reset ended");
   endtask
  
   task drive;
     gen2driv.get(trans);
     
     @(posedge vif.DRIVER.clk);
     if(trans.wr || trans.rd)
	 begin
     `DRIV_IF.wr <= trans.wr;
     `DRIV_IF.rd <= trans.rd;
	 `DRIV_IF.din <= trans.din;
     end
     
     trans.display("Driver");
   endtask

     task main;
      forever 
        begin
        fork
          wait(vif.rst);
          forever drive;
        join_any
        disable fork;
      end
     endtask
endclass