class scoreboard;

    transaction trans;	
	mailbox mon2scb;
	event next;
	bit [7:0] mem[4];
	
	function new(mailbox mon2scb);
	this.mon2scb = mon2scb;
	foreach(mem[i]) mem[i] = 8'hFF;
	endfunction

	task main;
	
	forever begin
	#10;
	mon2scb.get(trans);
      trans.display("Scoreboard");
      
    if(trans.wr_en)
    begin
	mem[trans.addr] = trans.wdata;	
      $display("[Scoreboard] - Data stored in mem[%0d] : %0d",trans.addr,trans.wdata);
    end
      
	else if(trans.rd_en)
	begin
	if(mem[trans.addr] != trans.rdata)
      $display("[Scoreboard] - data mismatch Addr = %0d \n Data expected = %0d Actual = %0d", trans.addr,mem[trans.addr],trans.rdata);
	else
      $display("[Scoreboard] - data match Addr = %0d \n Data expected = %0d Actual = %0d", trans.addr,mem[trans.addr],trans.rdata);
	end

	->next;
	end
	endtask
endclass

	
