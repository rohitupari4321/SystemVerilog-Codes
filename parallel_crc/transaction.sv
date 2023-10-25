class transaction;
  
  rand bit [3:0] data_in; 
  bit [4:0] data_out;
  
  function void display(string name);
    $display("[%0s] : data_in = %0b, data_out = %0d",name,data_in,data_out);   
  endfunction
  
endclass