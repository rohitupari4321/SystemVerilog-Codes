class transaction;
  
  rand bit pwrite;
 // rand bit penable;
  bit psel;
  bit penable;
  rand bit [31:0]paddr,pwdata;
  bit [31:0]prdata;
  bit pready,pslverr;
  
  constraint paddr_val { paddr>0; paddr<32; }
  
  function void display(string name);
    $display("[%0s] - PSEL : %0b PENABLE : %0b PWRITE : %0b PADDR : %0d PWDATA : %0d PRDATA : %0d PREADY : %0b PSLVERR : %0b",name,psel,penable,pwrite,paddr,pwdata,prdata,pready,pslverr);
  endfunction
  
endclass