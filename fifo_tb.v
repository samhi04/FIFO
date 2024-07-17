module tb;
reg clk,rst,wr,rd;
reg wrNBA,rdNBA;
reg [7:0] din=0,dinNBA=0;
wire [3:0] wrptr,rdptr;
wire [7:0] dout;

always @* wrNBA<=wr;
always @* rdNBA<=rd;
always @* dinNBA<=din;

fifo JAILER (clk,rst,dinNBA,wrNBA,rdNBA,wrptr,rdptr,dout);

always #5 clk = ~clk;

initial 
   begin 
   clk=0;rst=1;wr=0;rd=0;wrNBA=0;rdNBA=0;
   #2;
   rst=0;
   repeat(6) //writes 
      begin 
	     repeat(5) @ (posedge clk);
		 wrpulse($random);
	  end 
	repeat(6) //reads 
	   begin 
	      repeat(5) @(posedge clk);
		  rdpulse ;
	   end 
	repeat(5) @(posedge clk);
	repeat(10) //FUL
	begin 
	   repeat(5) @(posedge clk);
	   wrpulse($random);
	end 
	repeat(5) @(posedge clk);
	repeat(10) //FUL
	begin 
	   repeat(5) @(posedge clk);
	   rdpulse;
	end 
	repeat(5) @(posedge clk);
	$finish;
	end 
	
task wrpulse;
input [7:0] D;
begin 
   @(posedge clk);wr=1;din=D;
   @(posedge clk);wr=0;
end 
endtask 

task rdpulse;
begin 
   @(posedge clk);rd=1; 
   @(posedge clk);rd=0;
end 
endtask

endmodule    
	
	
   
