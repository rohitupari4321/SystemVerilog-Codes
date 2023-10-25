// Code your design here
// The "FIFO Basic Operation" test case is designed to verify the fundamental functionality of a FIFO (First-In-First-Out) memory. The test steps cover initialization, data writing, verification of data writing order, data reading, verification of data reading order, and testing boundary conditions such as overflow and underflow scenarios. This comprehensive test case helps ensure that the FIFO memory correctly stores and retrieves data in a first-in, first-out manner, adhering to its specified behavior and capacity constraints.

module fifo(input clk,rst,wr,rd,
            input [7:0]din,
            output reg [7:0]dout,
            output empty,full);
  
  reg [3:0]wptr,rptr;
  reg [4:0]cnt;
  reg [7:0]mem[0:15];
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          wptr <= 0;
          rptr <= 0;
          cnt <= 0;
        end
      
      else if(wr && !full)
        begin
          mem[wptr] <= din;
          wptr <= wptr + 1;
          cnt <= cnt + 1;
        end
      
      else if(rd && !empty)
        begin
          dout <= mem[rptr];
          rptr <= rptr + 1;
          cnt <= cnt - 1;
        end
    end
  
  assign empty =(cnt==0)  ? 1'b1 : 1'b0;
  assign full = (cnt==16)  ? 1'b1 : 1'b0;
  
endmodule