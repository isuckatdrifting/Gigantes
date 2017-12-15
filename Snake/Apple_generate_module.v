module Apple_generate_module//苹果产生控制模块
(
	input Clk_24mhz,
	input Rst_n,
	input [7:0] Head,//蛇头的坐标
	output reg [7:0] Apple_1,//苹果的坐标
	output reg [7:0] Apple_2,
	output reg [7:0] Apple_3,
	output reg Body_add_sig//蛇的身体增长信号
);
/***************************************************************************/
	reg [31:0] Count1;//32位的计数器，用来计数时间
	reg [7:0] Random_num_1;//8位的伪随机数，高4位为苹果X坐标 低4位为苹果Y坐标
	reg [7:0] Random_num_2;//8位的伪随机数，高4位为苹果X坐标 低4位为苹果Y坐标
	reg [7:0] Random_num_3;//8位的伪随机数，高4位为苹果X坐标 低4位为苹果Y坐标
	
	always@(posedge Clk_24mhz)
	begin	
		Random_num_1 <= Random_num_1 + 8'd126;  //用加法产生随机数，因为每一个时钟的上升沿都会让这个随机数+一个常数（这里假设是126），蛇吃苹果的时候
		Random_num_2 <= Random_num_2 + 8'd65;
		Random_num_3 <= Random_num_3 + 8'd89;
	end												 //的时刻不同，随机数就不一样，所以给人随机的感觉。
	
	always@(posedge Clk_24mhz or negedge Rst_n)
	begin
		if(!Rst_n)
		begin
			Count1 <= 32'd0;//时钟计数清零
			Apple_1 <= {4'd5,4'd8};//这是默认出现的苹果的位置
			Apple_2 <= {4'd6,4'd10};//这是默认出现的苹果的位置
			Apple_3 <= {4'd10,4'd8};//这是默认出现的苹果的位置
			Body_add_sig <= 1'd0;//0表示不增加身体节数
		end
		else	//if(Count1 == 32'd12000000)//0.5秒计时
				begin
					Count1 <= 32'd0;
					if(Apple_1 == Head | Apple_2 == Head | Apple_3 == Head)//蛇头吃到苹果,送身体增加信号
					begin//判断随机数是否超出屏幕的坐标范围，将随机数转换为下个苹果的X Y坐标
						Body_add_sig <= 1'd1;
						Apple_1[7:4] <= (Random_num_1[7:4] > 4'd15)?(Random_num_1[7:4] - 4'd15):((Random_num_1[7:4] == 4'd0)?4'd1:Random_num_1[7:4]);
						Apple_1[3:0] <= (Random_num_1[3:0] > 4'd15)?(Random_num_1[3:0] - 4'd15):((Random_num_1[3:0] == 4'd0)?4'd1:Random_num_1[3:0]);
						Apple_2[7:4] <= (Random_num_2[7:4] > 4'd15)?(Random_num_2[7:4] - 4'd15):((Random_num_2[7:4] == 4'd0)?4'd1:Random_num_2[7:4]);
						Apple_2[3:0] <= (Random_num_2[3:0] > 4'd15)?(Random_num_2[3:0] - 4'd15):((Random_num_2[3:0] == 4'd0)?4'd1:Random_num_2[3:0]);
						Apple_3[7:4] <= (Random_num_3[7:4] > 4'd15)?(Random_num_3[7:4] - 4'd15):((Random_num_3[7:4] == 4'd0)?4'd1:Random_num_3[7:4]);
						Apple_3[3:0] <= (Random_num_3[3:0] > 4'd15)?(Random_num_3[3:0] - 4'd15):((Random_num_3[3:0] == 4'd0)?4'd1:Random_num_3[3:0]);
					end   
					else
						Body_add_sig <= 1'd0;
				end
		//else
		//	Count1 <= Count1 + 32'd1;
	end
endmodule
