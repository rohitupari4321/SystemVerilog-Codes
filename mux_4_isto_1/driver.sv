class driver;
  
  transaction trans; 
  mailbox gen2driv;    
  virtual intf vif;    
  
  function new( virtual intf vif,mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task main;
  	  forever begin
      gen2driv.get(trans); 
       
       vif.i <= trans.i;
       vif.s <= trans.s;
       
       trans.display("Driver");
      end
  endtask
  
endclass
       