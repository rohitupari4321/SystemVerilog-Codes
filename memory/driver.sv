
`define DRIV_IF mem_vif.DRIVER.driver_cb

class driver;

  	transaction trans; 	
	virtual mem_intf mem_vif;
	mailbox gen2driv;
	
	function new(virtual mem_intf mem_vif,mailbox gen2driv);	
	  this.mem_vif = mem_vif;
	  this.gen2driv = gen2driv;
	endfunction
 
	task reset;
	wait(mem_vif.reset);
	$display("--------[DRIVER] Reset Started------------------");
	`DRIV_IF.wr_en <= 0;
	`DRIV_IF.rd_en <= 0;
	`DRIV_IF.addr <= 0;
	`DRIV_IF.wdata <= 0;
	wait(!mem_vif.reset);
	$display("--------[DRIVER] Reset ended------------");
	endtask

	task drive;
	gen2driv.get(trans);

	@(posedge mem_vif.DRIVER.clk);  
    // @(posedge mem_vif.DRIVER.clk); 
      if(trans.wr_en || trans.rd_en)
	begin
    `DRIV_IF.addr <= trans.addr;
	`DRIV_IF.wr_en <= trans.wr_en;
	`DRIV_IF.wdata <= trans.wdata;
    `DRIV_IF.rd_en <= trans.rd_en;
	end
      
     trans.display("Driver");
	endtask
	
	task main;
	forever 
	begin
	fork
		wait(mem_vif.reset);
		forever	drive();
	join_any
	disable fork;

	end
	endtask

endclass



