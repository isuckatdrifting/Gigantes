module Array_decoder
(
	input Clk,
	input rst,
	input [7:0] BodyA,
	input [7:0] BodyB,
	input [7:0] BodyC,
	input [7:0] BodyD,
	input [7:0] BodyE,
	input [7:0] BodyF,
	input [7:0] BodyG,
	input [7:0] BodyH,
	input [7:0] BodyI,
	input [7:0] BodyJ,
	input [7:0] BodyK,
	input [7:0] BodyL,
	input [7:0] BodyM,
	input [7:0] BodyN,
	input [7:0] BodyO,
	input [7:0] BodyP,
	input [7:0] Snake_length,
	input [7:0] Apple_1,
	input [7:0] Apple_2,
	input [7:0] Apple_3,
	input [2:0] Game_status,
	output reg [15:0] row,
	output reg [15:0] col
	);
parameter   END = 3'b100;
parameter START = 3'b001;

reg [7:0] counter;
reg [7:0] select;

always@(posedge Clk)begin
	if(~rst)begin
		counter <= 0;
	end
	else if(Game_status == END | Game_status == START) begin
		counter <= counter + 1;
		case(counter)
			8'd1:begin 
				col <= ~16'b0010_0000_0000_0000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd2:begin 
				col <= ~16'b0001_0000_0000_0000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd3:begin 
				col <= ~16'b0000_0100_0000_0000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd4:begin 
				col <= ~16'b0000_0000_0100_0000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd5:begin 
				col <= ~16'b0000_0000_0001_0000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd6:begin 
				col <= ~16'b0000_0000_0000_1000;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd7:begin 
				col <= ~16'b0000_0000_0000_0100;
				row <= ~16'b0000_0100_0000_0000;
				end
			8'd8:begin 
				col <= ~16'b0000_0000_0000_0010;
				row <= ~16'b0000_0100_0000_0000;
				end

			8'd9:begin 
				col <= ~16'b0100_0000_0000_0000;
				row <= ~16'b0000_0010_0000_0000;
				end
			8'd10:begin 
				col <= ~16'b0001_0000_0000_0000;
				row <= ~16'b0000_0010_0000_0000;
				end
			8'd11:begin 
				col <= ~16'b0000_0100_0000_0000;
				row <= ~16'b0000_0010_0000_0000;
				end
			8'd12:begin 
				col <= ~16'b0000_0010_0000_0000;
				row <= ~16'b0000_0010_0000_0000;
				end
			8'd13:begin 
				col <= ~16'b0000_0000_0100_0000;
				row <= ~16'b0000_0010_0000_0000;
				end
			8'd14:begin 
				col <= ~16'b0000_0000_0000_0010;
				row <= ~16'b0000_0010_0000_0000;
				end

			8'd15:begin 
				col <= ~16'b0100_0000_0000_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd16:begin 
				col <= ~16'b0001_0000_0000_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd17:begin 
				col <= ~16'b0000_0100_0000_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd18:begin 
				col <= ~16'b0000_0001_0000_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd19:begin 
				col <= ~16'b0000_0000_0100_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd20:begin 
				col <= ~16'b0000_0000_0001_0000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd21:begin 
				col <= ~16'b0000_0000_0000_1000;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd22:begin 
				col <= ~16'b0000_0000_0000_0100;
				row <= ~16'b0000_0001_0000_0000;
				end
			8'd23:begin 
				col <= ~16'b0000_0000_0000_0010;
				row <= ~16'b0000_0001_0000_0000;
				end
			
			8'd24:begin 
				col <= ~16'b0100_0000_0000_0000;
				row <= ~16'b0000_0000_1000_0000;
				end
			8'd25:begin 
				col <= ~16'b0001_0000_0000_0000;
				row <= ~16'b0000_0000_1000_0000;
				end
			8'd26:begin 
				col <= ~16'b0000_0100_0000_0000;
				row <= ~16'b0000_0000_1000_0000;
				end
			8'd27:begin 
				col <= ~16'b0000_0000_1000_0000;
				row <= ~16'b0000_0000_1000_0000;
				end
			8'd28:begin 
				col <= ~16'b0000_0000_0100_0000;
				row <= ~16'b0000_0000_1000_0000;
				end
			8'd29:begin 
				col <= ~16'b0000_0000_0000_0010;
				row <= ~16'b0000_0000_1000_0000;
				end

			8'd30:begin 
				col <= ~16'b0010_0000_0000_0000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd31:begin 
				col <= ~16'b0001_0000_0000_0000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd32:begin 
				col <= ~16'b0000_0100_0000_0000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd33:begin 
				col <= ~16'b0000_0000_0100_0000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd34:begin 
				col <= ~16'b0000_0000_0001_0000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd35:begin 
				col <= ~16'b0000_0000_0000_1000;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd36:begin 
				col <= ~16'b0000_0000_0000_0100;
				row <= ~16'b0000_0000_0100_0000;
				end
			8'd37:begin 
				col <= ~16'b0000_0000_0000_0010;
				row <= ~16'b0000_0000_0100_0000;
				
				counter <= 0;
				end
			endcase
	end
	else begin
		counter <= counter + 1;
		case(counter)
			8'd1:select <= Apple_1;
			8'd2:select <= Apple_2;
			8'd3:select <= Apple_3;
			8'd4:select <= BodyA;
			8'd5:select <= BodyB;
			8'd6:select <= BodyC;
			8'd7:begin
				if(Snake_length >= 4) select <= BodyD; 
				else counter <= 0;
				end
			8'd8:begin
				if(Snake_length >= 5) select <= BodyE;
				else counter <= 0;
				end
			8'd9:begin
				if(Snake_length >= 6) select <= BodyF;
				else counter <= 0;
				end
			8'd10:begin
				if(Snake_length >= 7) select <= BodyG;
				else counter <= 0;
				end
			8'd11:begin
				if(Snake_length >= 8) select <= BodyH;
				else counter <= 0;
				end
			8'd12:begin
				if(Snake_length >= 9) select <= BodyI;
				else counter <= 0;
				end
			8'd13:begin
				if(Snake_length >= 10) select <= BodyJ;
				else counter <= 0;
				end
			8'd14:begin
				if(Snake_length >= 11) select <= BodyK;
				else counter <= 0;
				end
			8'd15:begin
				if(Snake_length >= 12) select <= BodyL;
				else counter <= 0;
				end
			8'd16:begin
				if(Snake_length >= 13) select <= BodyM;
				else counter <= 0;
				end
			8'd17:begin
				if(Snake_length >= 14) select <= BodyN;
				else counter <= 0;
				end
			8'd18:begin
				if(Snake_length >= 15) select <= BodyO;
				else counter <= 0;
				end
			8'd19:begin
				if(Snake_length >= 16) select <= BodyP;
				else counter <= 0;
				counter <= 0;
				end
		endcase
		case(select[7:4])
			4'd0:	col <= ~(16'b1000_0000_0000_0000);
			4'd1:	col <= ~16'b0100_0000_0000_0000;
			4'd2:	col <= ~16'b0010_0000_0000_0000;
			4'd3:	col <= ~16'b0001_0000_0000_0000;
			4'd4:	col <= ~16'b0000_1000_0000_0000;
			4'd5:	col <= ~16'b0000_0100_0000_0000;
			4'd6:	col <= ~16'b0000_0010_0000_0000;
			4'd7:	col <= ~16'b0000_0001_0000_0000;
			4'd8:	col <= ~16'b0000_0000_1000_0000;
			4'd9:	col <= ~16'b0000_0000_0100_0000;
			4'd10:	col <= ~16'b0000_0000_0010_0000;
			4'd11:	col <= ~16'b0000_0000_0001_0000;
			4'd12:	col <= ~16'b0000_0000_0000_1000;
			4'd13:	col <= ~16'b0000_0000_0000_0100;
			4'd14:	col <= ~16'b0000_0000_0000_0010;
			4'd15:	col <= ~16'b0000_0000_0000_0001;
		endcase
		case(select[3:0])
			4'd0:	row <= ~16'b1000_0000_0000_0000;
			4'd1:	row <= ~16'b0100_0000_0000_0000;
			4'd2:	row <= ~16'b0010_0000_0000_0000;
			4'd3:	row <= ~16'b0001_0000_0000_0000;
			4'd4:	row <= ~16'b0000_1000_0000_0000;
			4'd5:	row <= ~16'b0000_0100_0000_0000;
			4'd6:	row <= ~16'b0000_0010_0000_0000;
			4'd7:	row <= ~16'b0000_0001_0000_0000;
			4'd8:	row <= ~16'b0000_0000_1000_0000;
			4'd9:	row <= ~16'b0000_0000_0100_0000;
			4'd10:	row <= ~16'b0000_0000_0010_0000;
			4'd11:	row <= ~16'b0000_0000_0001_0000;
			4'd12:	row <= ~16'b0000_0000_0000_1000;
			4'd13:	row <= ~16'b0000_0000_0000_0100;
			4'd14:	row <= ~16'b0000_0000_0000_0010;
			4'd15:	row <= ~16'b0000_0000_0000_0001;
		endcase
	end
end
endmodule

