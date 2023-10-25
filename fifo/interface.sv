interface intf(input clk,rst);
  
  logic wr,rd;
  logic [7:0]din,dout;
  logic empty,full;
  
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output wr,rd,din;
    input dout,empty,full;
  endclocking
  
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input wr,rd,din;
    input dout,empty,full;
  endclocking
  
  modport DRIVER (clocking driver_cb, input clk,rst);
  modport MONITOR (clocking monitor_cb, input clk,rst);

endinterface