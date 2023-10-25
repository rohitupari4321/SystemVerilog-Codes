class transaction;

rand bit data_in;
bit enb=1'b1;
bit [23:0]crc;
  
 function void display(string name);
   $display("[%0s] data_in : %0b enb : %0b crc : %0d",name,data_in,enb,crc);
 endfunction

endclass