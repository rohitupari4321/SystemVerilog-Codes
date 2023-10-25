`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;
  
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
  
  mailbox m1;       
  mailbox m2;       
  
  virtual intf vif;
  
  function new(virtual intf vif);
    this.vif = vif;
    m1 = new();
    m2 = new();
    gen = new(m1);
    driv = new(vif,m1);
    mon = new(vif,m2);
    scb = new(m2);
    
    gen.next = scb.next;
  endfunction
  
  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any
  endtask
  
  task post_test();
      wait(gen.done.triggered);
  endtask

  task run;
    test();
    post_test();
    $finish;
  endtask
  
endclass