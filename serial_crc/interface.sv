interface intf(input logic clk,rst);

 logic data_in;
 logic enb;
 logic [23:0] crc;

 clocking driver_cb @(posedge clk);
  default input #1 output #1;
   output data_in;
   output enb;
   input  crc;
 endclocking

clocking monitor_cb @(posedge clk);
 default input #1 output #1;
  input data_in;
  input enb;
  input crc;
 endclocking

modport DRIVER(clocking driver_cb,input clk,rst);
modport MONITOR(clocking monitor_cb,input clk,rst);

endinterface