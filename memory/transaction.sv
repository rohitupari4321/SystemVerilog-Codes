class transaction;	
	rand bit [1:0] addr;	
	rand bit wr_en;	
	rand bit rd_en;
	rand bit[7:0] wdata;	
	bit[7:0] rdata;	
		
	// constraint, to generate any one among write and read
	constraint wr_rd_c { wr_en != rd_en; }
	
  function void display(string name);
    $display("[%0s] - addr : %0d wr_en : %0b rd_en : %0b wdata : %0d rdata : %0d",name,addr,wr_en,rd_en,wdata,rdata);
  endfunction
	
	// deep copy method
	function transaction copy();	
	copy = new();	
	copy.addr = this.addr;	
	copy.wr_en = this.wr_en;
	copy.rd_en = this.rd_en;
	copy.wdata = this.wdata;		
	endfunction	
endclass
	