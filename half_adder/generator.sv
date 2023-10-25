class generator;
  
  transaction trans;  // handle of transaction class  
  mailbox gen2driv;   // mailbox declaration
  
   int count;
   event next,done;
  
  function new(mailbox gen2driv);  // creation of mailbox and constructor
    this.gen2driv = gen2driv;
    trans = new();   // object for transaction class
  endfunction
  
  task main();
    
    repeat(count)
      begin
        trans.randomize();  // randomization of transaction
        gen2driv.put(trans);    // putting data into mailbox
        $display("----------------------------------------------------");
        trans.display("Generator");  // checking purpose 
        @(next);
      end
    ->done;
  endtask 
endclass
    
  