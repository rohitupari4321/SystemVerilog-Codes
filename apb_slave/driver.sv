`define DRIV_IF vif.DRIVER.driver_cb

class driver;
  
  transaction trans;
  mailbox gen2driv;
  virtual intf vif;
  
  function new(virtual intf vif,mailbox gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction
  
  task reset;
    wait(!vif.rst);
    $display("Driver reset started");
    `DRIV_IF.psel <= 0;
    `DRIV_IF.penable <= 0;
    `DRIV_IF.pwrite <= 0;
    `DRIV_IF.paddr <= 0;
    `DRIV_IF.pwdata <= 0;
    wait(vif.rst);
    $display("Driver reset ended");
  endtask
  
  
  /* task drive;
    gen2driv.get(trans);
    
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.psel <= 1;
    
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.penable <= 1;
    `DRIV_IF.pwrite <= 1;
   
    `DRIV_IF.paddr <= trans.paddr;
    `DRIV_IF.pwdata <= trans.pwdata;
    
    @(posedge vif.DRIVER.clk);
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.penable <= 0;
    
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.penable <= 1; 
    `DRIV_IF.pwrite <= 0;

    trans.display("Driver");
  endtask  */
  
  task write;
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.psel <= 1;
    `DRIV_IF.pwrite <= trans.pwrite;
    `DRIV_IF.penable <= 0; 
    //`DRIV_IF.penable <= trans.penable; 
    `DRIV_IF.paddr <= trans.paddr;
    `DRIV_IF.pwdata <= trans.pwdata;
    
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.penable <= 1;
    //`DRIV_IF.penable <= trans.penable; 

    @(posedge vif.DRIVER.clk);
    `DRIV_IF.psel <= 0;

    // pready = 1;
    //trans.display("Driver");
    //$display("[Driver] - PSEL : %0b PENABLE : %0b PWRITE : %0b PADDR : %0d PWDATA : %0d PRDATA : %0d PREADY : %0b PSLVERR : %0b",`DRIV_IF.psel,`DRIV_IF.penable,`DRIV_IF.pwrite,`DRIV_IF.paddr,`DRIV_IF.pwdata,`DRIV_IF.prdata,`DRIV_IF.pready,`DRIV_IF.pslverr);
  endtask
  
  task read;
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.psel <= 1;
    `DRIV_IF.pwrite <= trans.pwrite;
    `DRIV_IF.penable <= 0; 
        //`DRIV_IF.penable <= trans.penable; 

    `DRIV_IF.paddr <= trans.paddr;
    
    @(posedge vif.DRIVER.clk);
    `DRIV_IF.penable <= 1;
       // `DRIV_IF.penable <= trans.penable; 

     @(posedge vif.DRIVER.clk);
    `DRIV_IF.psel <= 0;
    
    //trans.prdata = `DRIV_IF.prdata;
    // pready = 1;
    //trans.display("Driver");
   // $display("[Driver] - PSEL : %0b PENABLE : %0b PWRITE : %0b PADDR : %0d PWDATA : %0d PRDATA : %0d PREADY : %0b PSLVERR : %0b",`DRIV_IF.psel,`DRIV_IF.penable,`DRIV_IF.pwrite,`DRIV_IF.paddr,`DRIV_IF.pwdata,`DRIV_IF.prdata,`DRIV_IF.pready,`DRIV_IF.pslverr);
  endtask
  
  task main;
    forever begin
      gen2driv.get(trans);
      fork
        wait(!vif.rst);
        forever begin
          trans.display("Driver");
          
          if(trans.pwrite==1)
            write();
          else
            read();
          
        end
      join_any
      disable fork;
        
    end
  endtask
  
endclass