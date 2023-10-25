class transaction;
  rand bit [7:0]din;
  rand bit wr,rd;
  bit [7:0]dout;
  bit empty,full;
  
  constraint signal {wr!=rd;}
  
  function void display(string name);
    $display("[%0s] - din : %0d wr : %0b rd : %0b dout : %0d empty : %0b full : %0b",name,din,wr,rd,dout,empty,full);
  endfunction
  
  function transaction copy();
    copy = new();
    copy.wr = this.wr;
    copy.rd = this.rd;
    copy.din = this.din;
    copy.dout = this.dout;
    copy.empty = this.empty;
    copy.full = this.full;
  endfunction
  
endclass