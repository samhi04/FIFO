module fifo(clk,rst,din,wr,rd,wrptr,rdptr,dout);
input clk,rst,wr,rd;
input [7:0] din;
output [7:0] dout;
output reg [3:0] wrptr,rdptr;

wire [3:0] wrptrnext;
wire [3:0] rdptrnext;

enum {EMP,PAR,FUL} state;

always @(posedge clk or posedge rst)
begin 
   if (rst) state<=EMP;
   else 
   case (state)
   EMP: state<= wr ? PAR : EMP;
   PAR: case(1)
        wr && (wrptr+1 == rdptr) : state<=FUL;
        rd && (rdptr+1 == wrptr) : state<=EMP;
		default: state<=PAR;
		endcase 
   FUL:state <= rd ? PAR : FUL;
   endcase 
end 

assign wrptrnext = (wrptr==10) ? 1 : (wrptr+1);
assign rdptrnext = (rdptr==10) ? 1 : (rdptr+1);

always @(posedge clk or posedge rst)
begin 
   if (rst) rdptr<=0;
   else 
   case(state)
   EMP: rdptr <= rdptr;
   PAR,FUL: rdptr <= rd ? (rdptrnext):rdptr;
   endcase
end 

endmodule 

