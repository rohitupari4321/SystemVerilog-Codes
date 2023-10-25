class generator;
  transaction trans;
  mailbox gen2driv;
  event done,sconext;
  
  int count;
  
  function new(mailbox gen2driv);
    this.gen2driv=gen2driv;
    trans = new();
  endfunction
    
    task main;
      repeat(count)
        begin
          assert(trans.randomize()) 
          else $display("[Gen] - Randomization failed");
          gen2driv.put(trans.copy);
          $display("----------");
          trans.display("Generator");
          @(sconext);
        end
      ->done;
    endtask
    
endclass