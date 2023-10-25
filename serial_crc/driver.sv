`define DRIV_IF vif.DRIVER.driver_cb

class driver;

 mailbox gen2driv;

 virtual intf vif;
  
 function new(virtual intf vif, mailbox gen2driv);
  this.vif = vif;
  this.gen2driv = gen2driv;
 endfunction

task reset;
  wait(vif.rst);
  $display("--------[DRIVER] Reset started----------");
  vif.data_in <= 0;
  vif.enb <= 0;
  wait(!vif.rst);
  $display("--------[DRIVER] Reset ended------------");
  `DRIV_IF.enb <= 1;  
endtask

  task drive;
    transaction trans;    
    gen2driv.get(trans);  
    @(posedge vif.DRIVER.clk);      
    `DRIV_IF.data_in <= trans.data_in;  
    trans.display("Driver");
  endtask
  
task main;
    forever begin
	fork
	wait(vif.rst);
    forever	drive();
	join_any
	disable fork;
	end
 endtask

endclass
