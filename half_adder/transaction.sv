class transaction; //packet class
  
  // stimulus are delared with rand keyword
  rand bit a;
  rand bit b;
  
  bit sum;
  bit carry;
  
  // function for displaying values of a,b and sum,carry
  function void display(string name);  
    $display("[%0s] - a:%0d b:%0d sum:%0d carry:%0d",name,a,b,sum,carry);
  endfunction
  
endclass
    
  