module fifo(
input clk, 
input rst, 
inptu wr, 
input rd, 
output reg [3:0] wrptr, 
output reg [3:0] rdptr,
input [7:0] din, 
output reg [7:0] dout
);

reg [7:0] Box1,Box2,Box3,Box4,Box5,Box6,Box7,Box8,Box9,Box10;
enum {EMP,PAR,FUL} state;
wire [3:0] wrptrnext;
wire [3:0] rdptrnext;

always @(posedge clk or posedge rst)
begin 
   if (rst) state<=EMP;
   else 
   case(state)
   EMP:state <= wr ? PAR : EMP;
   PAR:case(1)
       wr && (wrptrnext==rdptr):state<=FUL;
       rd && (rdptrnext==wrptr):state<=EMP;
	   //default: state<=PAR;
	endcase 
	FUL:state<=rd ? PAR:FUL;
	endcase
	end 
	
	assign wrptrnext = wrptr==10 ? 1 : (wrptr+1);
	assign rdptrnext = rdptr==10 ? 1 : (rdptr+1);
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) wrptr<=1;
	   else 
	   case(state)
	   EMP,PAR:wrptr <= ? wrptrnext : wrptr;
	   FUL: wrptr <= wrptr;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) rdptr<=1;
	   else 
	   case(state)
	   EMP,PAR:rdptr <= ? rdptrnext : rdptr;
	   FUL: rdptr <= rdptr;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box1<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box1 <= (wrptr==1) ? din:Box1;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box2<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box2 <= (wrptr==2) ? din:Box2;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box3<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box3 <= (wrptr==3) ? din:Box3;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box4<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box4 <= (wrptr==4) ? din:Box4;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box5<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box5 <= (wrptr==5) ? din:Box5;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box6<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box6 <= (wrptr==6) ? din:Box6;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box7<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box7 <= (wrptr==7) ? din:Box7;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box8<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box8 <= (wrptr==8) ? din:Box8;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box9<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box9 <= (wrptr==9) ? din:Box9;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	   if (rst) Box10<=0;
	   else 
	   case(state)
	   EMP,PAR:if (wr) Box10 <= (wrptr==10) ? din:Box10;
	   endcase 
	end 
	
	always @(posedge clk or posedge rst)
	begin 
	if (rst) dout<=0;
	else 
	case (state)
	EMP: dout <= dout;
	PAR,FUL: if (rd)
	            case(rdptr)
				1: dout<=Box1;
				2: dout<=Box2;
				3: dout<=Box3;
				4: dout<=Box4;
				5: dout<=Box5;
				6: dout<=Box6;
				7: dout<=Box7;
				8: dout<=Box8;
				9: dout<=Box9;
				10: dout<=Box10;
				endcase 
			else dout<=dout;
	endcase 
	end 
	
endmodule 
	
	
	