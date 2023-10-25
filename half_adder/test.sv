`include "environment.sv"

program test(intf i_intf);
  
  environment env;
  
  initial
    begin
      env = new(i_intf);
      env.gen.count = 4;  // number of inputs
      env.run();
    end
  
endprogram