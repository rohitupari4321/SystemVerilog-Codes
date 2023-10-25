class transaction; 
  
  rand bit [3:0]i;
  rand bit [1:0]s;
  
  bit y;
  
  function void display(string name);  
    $display("[%0s] - i:%0b s:%0d y:%0b",name,i,s,y);
  endfunction
  
endclass
    
  