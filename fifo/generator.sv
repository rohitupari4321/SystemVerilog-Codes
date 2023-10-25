class generator;
  
  transaction trans;
  mailbox gen2driv;
  
  event next,done;
  
  int count;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
    trans = new();
  endfunction
  
  task main;
    repeat(count)
      begin
        assert(trans.randomize()) 
          else $display("Randomization failed");
        
        gen2driv.put(trans.copy);
        $display("--------------------------------------");
        trans.display("Generator");
        @(next);
      end
    ->done;
  endtask
  
endclass