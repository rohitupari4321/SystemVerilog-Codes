class scoreboard;
  transaction trans;
  mailbox mon2scb;
  
  event gen_sconext;
  
  function new(mailbox mon2scb);
    this.mon2scb=mon2scb;
  endfunction
  
  task main;
    forever begin
      #10;
      //trans = new();
      mon2scb.get(trans);
      trans.display("Scoreboard");
      if(trans.dout == trans.din)
        $display("Correct - dout=%0b din=%0b",trans.dout,trans.din);
      else
        $display("Result unexpected");
      
      ->gen_sconext;
    end
  endtask
endclass

