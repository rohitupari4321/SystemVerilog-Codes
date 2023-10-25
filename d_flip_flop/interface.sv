interface intf(input logic clk,rst);
  
  logic din;
  logic dout;
  
  clocking driver_cb @(posedge clk);
    input dout;
    output din;
  endclocking
  
   clocking monitor_cb @(posedge clk);
    input din;
    input dout;
  endclocking
  
  modport DRIVER(clocking driver_cb,input clk,rst);
  modport MONITOR(clocking monitor_cb,input clk,rst);
      
endinterface