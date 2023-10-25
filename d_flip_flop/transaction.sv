class transaction;
  rand bit din;
  bit dout;
  
  function transaction copy();
    copy = new();
    copy.din = this.din;
    copy.dout = this.dout;
  endfunction
  
  function void display(string name);
    $display("[%0s] : din:%0b dout:%0b ",name,din,dout);
  endfunction
endclass