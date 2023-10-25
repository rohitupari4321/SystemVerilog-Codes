class generator;
  
  transaction trans;
  
  int repeat_count;
  event ended,sco_next;
  
 mailbox gen2driv;
 
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction

task main();
  repeat(repeat_count)
  begin
    trans = new();
   if(!trans.randomize())
    $fatal("Randomization failed");
    gen2driv.put(trans);
    $display("-------------------------------------------");
    trans.display("Generator");
    @(sco_next);
  end
  ->ended;
endtask

endclass