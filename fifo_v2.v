module fifo_v2 (
input clk, 
input rst, 
input wr, 
input rd, 
output reg [3:0] wrptr, 
output reg [3:0] rdptr, 
input [7:0] din, 
output reg [7:0] dout 
);

reg [7:0] Box[1:10]; //reg [7:0] Box[1],Box[2]....Box[10];
enum {EMP,PAR,FUL} state;

wire [3:0] wrptrnext;
wire [3:0] rdptrnext; 
integer i; 

always @(posedge clk or posedge rst)
begin 
   if (rst) state<=EMP;
   else 
   case (state)
   EMP: state <= wr ? PAR:EMP;
   PAR: case(1)
        wr && (wrptrnext==rdptr) : state<=FUL;
        rd && (rdptrnext==wrptr) : state<=EMP;
		//default: state<=PAR;
		endcase 
   FUL: state <= rd ? PAR : FUL;
   endcase 
end

assign wrptrnext = wrptr==10 ? 1 : (wrptr+1);
assign rdptrnext = rdptr==10 ? 1 : (rdptr+1);

always @(posedge clk or posedge rst)
begin 
   if (rst) wrptr <= 1;
   else
   case(state)
   EMP,PAR: wrptr <= wr ? wrptrnext : wrptr;
   FUL: wrptr <= wrptr;
   endcase 
end 

always @(posedge clk or posedge rst)
begin 
   if (rst) rdptr <= 1;
   else
   case(state)
   FUL,PAR: rdptr <= rd ? rdptrnext : rdptr;
   EMP: rdptr <= rdptr;
   endcase 
end 

always @(posedge clk or posedge rst)
begin 
  if (rst) for (i=0;i<=10;i=i+1) Box[i] <= 0;
  else 
  case(state)
  EMP,PAR: if (wr) Box[wrptr] <= din;
  endcase 
end 

always @(posedge clk or posedge rst)
begin 
  if (rst) dout<=0;
  else 
  case (state)
  PAR,FUL: if (rd) dout <= Box[rdptr];
  endcase 
 end 
 
endmodule 

