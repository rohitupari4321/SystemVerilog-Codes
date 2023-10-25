class generator;
  
  transaction trans;   
  mailbox gen2driv;   
  
   int count;
   event next,done;
  
  function new(mailbox gen2driv);  
    this.gen2driv = gen2driv;
    trans = new();  
  endfunction
  
  task main();
    
    repeat(count)
      begin
        trans.randomize(); 
        gen2driv.put(trans);    
        $display("--------------------------------------------");
        trans.display("Generator");   
        @(next);
      end
    ->done;
  endtask 
endclass
    
  