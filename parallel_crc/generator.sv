class generator;
  
  transaction trans;
	mailbox gen2driv;

	int count;
	event done,next;
		
	function new(mailbox gen2driv);
	this.gen2driv = gen2driv;
	trans = new();
	endfunction

	task main();
	repeat(count)
	begin
	if(!trans.randomize())
	$fatal("Generator-Transaction Randomization failed");
    gen2driv.put(trans);
    trans.display("Generator");
    @(next);
	end
	->done;
	endtask
endclass