`include "interface.sv"
`include "test.sv"

module testbench();

	bit clk;
	bit rst;

	always #5 clk=~clk;

	initial begin
      // active low reset
	rst=0;
	#10 rst=1;
	end

	intf vif(clk,rst);

	test TEST(vif);

     apb_ram DUT(
       .presetn(vif.rst),
       .pclk(vif.clk),
       .psel(vif.psel),
       .penable(vif.penable),
       .pwrite(vif.pwrite),
       .paddr(vif.paddr),
       .pwdata(vif.pwdata),
       .prdata(vif.prdata),
       .pready(vif.pready),
       .pslverr(vif.pslverr));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    
  end

endmodule








/*
module apb_tb();
  reg presetn;
  reg pclk;
  reg psel;
  reg penable;
  reg pwrite;
  reg [31:0] paddr,pwdata;
  wire [31:0] prdata;
  wire pready,plsverr;
 
  apb_ram apb( .presetn(presetn),
               .pclk(pclk),
               .psel(psel),
               .penable(penable),
               .pwrite(pwrite),
               .paddr(paddr),
               .pwdata(pwdata),
               .prdata(prdata),
               .pready(pready),
               .pslverr(pslverr)
             );
 
  always #5 pclk = ~pclk;
 
  initial begin
   
    // $dumpfile("dump.vcd");
    //$dumpvars;
   
   
    $monitor("mem[8] : %0x\n prdata : %0x ",apb.mem[8],prdata);
    pclk = 0;
    presetn = 0;
    psel = 0;
    penable = 0;
    pwrite = 0;
    pwdata = 0;
    paddr = 0;
   
   #5 presetn = 0;
     
       psel = 0;
       
   
    #10 presetn = 1;
       
   
    #10 psel = 1;
   
    #10 penable = 1;
        pwrite = 1;
         paddr = 8;
        pwdata = 32'h1234_5678;
   
    #20 penable = 0;
   
    #10 penable = 1;
        pwrite = 0;
   
   
 #50   $finish;
   
  end
 
endmodule
*/