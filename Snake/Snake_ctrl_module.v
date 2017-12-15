module Snake_ctrl_module//蛇的运动情况控制模块
(
	input Clk_24mhz,//24M时钟
	input Rst_n,//全局复位信号	
	input Key_left,//左按键
	input Key_right,//右按键
	input Key_up,//上按键
	input Key_down,//下按键
	output [7:0] Head,	//蛇的头部那一格的坐标
	input Body_add_sig,//身体长度增加信号
	input [2:0] Game_status,//3种游戏状态，START：001；PLAY：010；END：100；
	output reg Hit_body_sig,//撞到身体信号
	output reg Hit_wall_sig,//撞到墙信号
	input Flash_sig,//闪动信号
	output reg [7:0] BodyA,//高4位：X，低4位：Y
	output reg [7:0] BodyB,
	output reg [7:0] BodyC,
	output reg [7:0] BodyD,
	output reg [7:0] BodyE,
	output reg [7:0] BodyF,
	output reg [7:0] BodyG,
	output reg [7:0] BodyH,
	output reg [7:0] BodyI,
	output reg [7:0] BodyJ,
	output reg [7:0] BodyK,
	output reg [7:0] BodyL,
	output reg [7:0] BodyM,
	output reg [7:0] BodyN,
	output reg [7:0] BodyO,
	output reg [7:0] BodyP,
	output reg [7:0] Snake_length
);
/***************************************************************************/
	localparam Up = 2'b00;
	localparam Down = 2'b01;
	localparam Left = 2'b10;
	localparam Right = 2'b11;
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;
	parameter   END = 3'b100;
/***************************************************************************/

	reg [31:0] Count;//32位计数器，用来计时
	wire [1:0] Direct;
	reg [1:0] Direct_r;//寄存方向的寄存器
	reg [1:0] Direct_next;//下一个方向的寄存器
	assign Direct = Direct_r;
	reg Direct_left;//方向左
	reg Direct_right;//方向右
	reg Direct_up;//方向上
	reg Direct_down;//方向下
	assign Head = BodyA;//BodyA表示一整条蛇身体各节的格坐标
	
/***************************************************************************/
	always @ (posedge Clk_24mhz or negedge Rst_n)
	begin
		if(!Rst_n)
			Direct_r <= Right;//默认一出来就是向右前进
		else
			Direct_r <= Direct_next;
	end
/***************************************************************************/
	
	always @ (posedge Clk_24mhz or negedge Rst_n)
	begin
		if(!Rst_n)
		begin
			Count <= 32'd0;
			//X从左到右递增，Y从上到下递增
			BodyA <= {4'd10,4'd5};
			BodyB <= {4'd9,4'd5};
			BodyC <= {4'd8,4'd5};
			//后面的身体暂时还没有，所以没有所谓的坐标，都为0，最多是16节身体
			BodyC <= {4'd0,4'd0};
			BodyD <= {4'd0,4'd0};
			BodyE <= {4'd0,4'd0};
			BodyF <= {4'd0,4'd0};
			BodyG <= {4'd0,4'd0};
			BodyH <= {4'd0,4'd0};
			BodyI <= {4'd0,4'd0};
			BodyJ <= {4'd0,4'd0};
			BodyK <= {4'd0,4'd0};
			BodyL <= {4'd0,4'd0};
			BodyM <= {4'd0,4'd0};
			BodyN <= {4'd0,4'd0};
			BodyO <= {4'd0,4'd0};
			BodyP <= {4'd0,4'd0};

			Hit_wall_sig <= 1'd0;
			Hit_body_sig <= 1'd0;
		end
		else	if(Count == 32'd6_000_000) //0.02us*12'500'000 = 0.25s，每秒移动四次
				begin
					Count <= 32'd0;
		//************************************************下面改了			
					if(Game_status == END)
					begin
						BodyA <= {4'd10,4'd5};
						BodyB <= {4'd9,4'd5};
						BodyC <= {4'd8,4'd5};
						//后面的身体暂时还没有，所以没有所谓的坐标，都为0，最多是16节身体
						BodyC <= {4'd0,4'd0};
						BodyD <= {4'd0,4'd0};
						BodyE <= {4'd0,4'd0};
						BodyF <= {4'd0,4'd0};
						BodyG <= {4'd0,4'd0};
						BodyH <= {4'd0,4'd0};
						BodyI <= {4'd0,4'd0};
						BodyJ <= {4'd0,4'd0};
						BodyK <= {4'd0,4'd0};
						BodyL <= {4'd0,4'd0};
						BodyM <= {4'd0,4'd0};
						BodyN <= {4'd0,4'd0};
						BodyO <= {4'd0,4'd0};
						BodyP <= {4'd0,4'd0};
						Hit_wall_sig <= 1'd0;
						Hit_body_sig <= 1'd0;
					end
					else
					begin//撞墙有四种情况，上下左右，撞到上，Y = 0；撞到下边，Y = 15；撞到左边，X = 0；撞到右边，X = 15
						if(((Direct == Up) && (BodyA[3:0] == 4'd0)) | 
							((Direct == Down) && (BodyA[3:0] == 4'd15)) | 
							((Direct == Left) && (BodyA[7:4] == 4'd0)) | 
							((Direct == Right) && (BodyA[7:4] == 4'd15)))

							Hit_wall_sig <= 1'd1; //directly hit the wall
						else if(((BodyA[3:0] == BodyB[3:0]) && (BodyA[7:4] == BodyB[7:4]) && (Snake_length == 8'd2)) | 
								((BodyA[3:0] == BodyC[3:0]) && (BodyA[7:4] == BodyC[7:4]) && (Snake_length == 8'd3)) | 
								((BodyA[3:0] == BodyD[3:0]) && (BodyA[7:4] == BodyD[7:4]) && (Snake_length == 8'd4)) | 
								((BodyA[3:0] == BodyE[3:0]) && (BodyA[7:4] == BodyE[7:4]) && (Snake_length == 8'd5)) | 
								((BodyA[3:0] == BodyF[3:0]) && (BodyA[7:4] == BodyF[7:4]) && (Snake_length == 8'd6)) | 
								((BodyA[3:0] == BodyG[3:0]) && (BodyA[7:4] == BodyG[7:4]) && (Snake_length == 8'd7)) | 
								((BodyA[3:0] == BodyH[3:0]) && (BodyA[7:4] == BodyH[7:4]) && (Snake_length == 8'd8)) | 
								((BodyA[3:0] == BodyI[3:0]) && (BodyA[7:4] == BodyI[7:4]) && (Snake_length == 8'd9)) | 
								((BodyA[3:0] == BodyJ[3:0]) && (BodyA[7:4] == BodyJ[7:4]) && (Snake_length == 8'd10)) | 
								((BodyA[3:0] == BodyK[3:0]) && (BodyA[7:4] == BodyK[7:4]) && (Snake_length == 8'd11)) | 
								((BodyA[3:0] == BodyL[3:0]) && (BodyA[7:4] == BodyL[7:4]) && (Snake_length == 8'd12)) | 
								((BodyA[3:0] == BodyM[3:0]) && (BodyA[7:4] == BodyM[7:4]) && (Snake_length == 8'd13)) | 
								((BodyA[3:0] == BodyN[3:0]) && (BodyA[7:4] == BodyN[7:4]) && (Snake_length == 8'd14)) | 
								((BodyA[3:0] == BodyO[3:0]) && (BodyA[7:4] == BodyO[7:4]) && (Snake_length == 8'd15)) | 
								((BodyA[3:0] == BodyP[3:0]) && (BodyA[7:4] == BodyP[7:4]) && (Snake_length == 8'd16)))
								
								Hit_body_sig <= 1'd1;//蛇头的Y坐标=任一位身体的Y坐标，头的X坐标=任一位身体的X坐标，身体的该长度位存在=碰到身体
						else
						begin//产生跟随现象，后一节跟着前一节
							BodyB <= BodyA;
							BodyC <= BodyB;
							BodyD <= BodyC;
							BodyE <= BodyD;
							BodyF <= BodyE;
							BodyG <= BodyF;
							BodyH <= BodyG;
							BodyI <= BodyH;
							BodyJ <= BodyI;
							BodyK <= BodyJ;
							BodyL <= BodyK;
							BodyM <= BodyL;
							BodyN <= BodyM;
							BodyO <= BodyN;
							BodyP <= BodyO;
						
							case(Direct)//选择的是按键，在墙边的时候,根据按下按键判断是否撞墙 否则按规律改变头部坐标							
								Up:
									begin
									if(BodyA[3:0] == 4'd0)//如果第一个移动的节坐标已经是1了，再按上，则会撞墙
											Hit_wall_sig <= 1'd1;
										else
											BodyA[3:0] <= BodyA[3:0] - 4'd1;//注意坐标系，这里是 - 1，因为最上面是0，所以向上走的话，Y是 - 1的。
									end
								Down:
									begin
										if(BodyA[3:0] == 4'd15)
											Hit_wall_sig <= 1'd1;
										else
											BodyA[3:0] <= BodyA[3:0] + 4'd1;
									end
								Left:
									begin
										if(BodyA[7:4] == 4'd0)
											Hit_wall_sig <= 1'd1;
										else
											BodyA[7:4] <= BodyA[7:4] - 4'd1;//注意坐标系，这里是 + 1，因为最左面是0，所以向左走的话，X是 - 1的。	
									end
								
								Right:
									begin
										if(BodyA[7:4] == 4'd15)
											Hit_wall_sig <= 1'd1;
										else
											BodyA[7:4] <= BodyA[7:4] + 4'd1;
									end
							endcase																	
						end					
					end
			end 
		else
			Count <= Count + 32'd1;//如果不满足时间到0.25秒，则计数器加1
	end	
/***************************************************************************/
	always @ (posedge Clk_24mhz)//给四个按键赋值
	begin
		if(Key_left == 1'd1)
				Direct_left <= 1'd1;//按键信息锁存
		else if(Key_right == 1'd1)
				Direct_right <= 1'd1;
		else if(Key_up == 1'd1)
				Direct_up <= 1'd1;
		else if(Key_down == 1'd1)
				Direct_down <= 1'd1;			
		else 
		begin
			Direct_left <= 1'd0;
			Direct_right <= 1'd0;
			Direct_up <= 1'd0;
			Direct_down <= 1'd0;
		end
	end
	/***************************************************************************/
	
	always @ (*)//电平触发
	begin   //根据当前运动状态即按下键位判断下一步运动情况，不在墙边的情况
		Direct_next = Right;//默认刚开始是向右走
		case(Direct)
			Up://根据按键进行三个方向的选择，这里是按键按下的时候，信号传导Direct_next，然后由Direct_next送给Direct_r，最后再赋值给Direct
				begin
					if(Direct_left)
						Direct_next = Left;
					else if(Direct_right)
						Direct_next = Right;
					else
						Direct_next = Up;
				end
			Down:
				begin
					if(Direct_left)
						Direct_next = Left;
					else if(Direct_right)
						Direct_next = Right;
					else
						Direct_next = Down;
				end		
			Left:
				begin
					if(Direct_up)
						Direct_next = Up;
					else if(Direct_down)
						Direct_next = Down;
					else
						Direct_next = Left;
				end
			Right:
				begin
					if(Direct_up)
						Direct_next = Up;
					else if(Direct_down)
						Direct_next = Down;
					else
						Direct_next = Right;
				end		
		endcase
	end

/***************************************************************************/
	reg Eaten_sig;//吃苹果状态
	
	always @ (posedge Clk_24mhz or negedge Rst_n)//吃下苹果没？，吃下则Body_add_sig == 1，显示体长增加一位
	begin
		if(!Rst_n)
		begin
			Snake_length <= 8'd3;//0111，3节是亮的
			Eaten_sig <= 1'd0;//初始显示长度为3，Snake_light_sig = 0000_0000_0111
		end		
		else if(Game_status == END)
				begin
					Snake_length <= 8'd3;
					Eaten_sig <= 1'd0;
				end 
		else				
		begin//判断蛇头与苹果坐标是否重合
			case(Eaten_sig)
				1'd0	:
					begin
						if(Body_add_sig)
						begin
							Snake_length <= Snake_length + 8'd1;
							Eaten_sig <= 1'd1;//“吃下”信号
						end
						else
							Snake_length <= Snake_length;
					end
				1'd1	:
					begin
						if(!Body_add_sig)//等待身体增长信号为0
							Eaten_sig <= 0;
						else
							Eaten_sig <= Eaten_sig;
					end
			endcase
		end
	end
endmodule
