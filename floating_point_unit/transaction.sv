class transaction;
  
  rand bit [31:0] instruction;
  
  bit [31:0] result;
  bit exp_flag;
  
  function void display(string name);
    $display("[%0s] - instruction = %0b, result = %0b, exp_flag = %0b",name,instruction,result,exp_flag);    
  endfunction  
  
endclass