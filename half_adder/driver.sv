class driver;
  
  transaction trans; //handle of transaction class to get the mailbox data
  mailbox gen2driv;    //handle of maibox
  virtual intf vif;    //vif is a handle of virtual interface
  
  function new( virtual intf vif,mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task main;
  	  forever begin
      gen2driv.get(trans);  // getting trans data from mailbox
       
       vif.a <= trans.a;
       vif.b <= trans.b;
       
     //  trans.sum = vif.sum;      // displayign this two line is sampling
     // trans.carry = vif.carry;  // not necessary to display these lines
       trans.display("Driver");
      end
  endtask
  
endclass
       