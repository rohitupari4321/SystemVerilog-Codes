interface intf(input logic clk,rst);
  
      logic psel,penable,pwrite;
  	  logic [31:0] paddr,pwdata,prdata;
      logic pready,pslverr;
  
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output psel,penable,pwrite;
    output paddr,pwdata;
    input prdata;
    input pready,pslverr;
  endclocking
  
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input psel,penable,pwrite;
    input paddr,pwdata;
    input prdata;
    input pready,pslverr;
  endclocking
  
  modport DRIVER (clocking driver_cb , input clk,rst);
    modport MONITOR (clocking monitor_cb , input clk,rst);
    
endinterface