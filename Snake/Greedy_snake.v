module Greedy_snake//贪吃蛇顶层模块
(
	input Clk,//24MHZ的全局时钟
	input Rst_n,//全局复位信号
	input Left,//左按键
	input Right,//右按键
	input Up,//上按键
	input Down,//下按键
	output [7:0] Smg_duan,//数码管段选
	output [3:0] Smg_we,//数码管位选
	output [15:0] Array_row,
	output [15:0] Array_col
);
/***************************************************************************/
	wire Clk_24mhz;
	wire Clk_10khz;	
	
	altpll0	altpll0_inst (
	.inclk0(Clk),
	.c0(Clk_24mhz),
	.c1(Clk_10khz)
	);	
/***************************************************************************/
	wire Key_left;//左按键
	wire Key_right;//右按键
	wire Key_up;//上按键
	wire Key_down;//下按键
	wire [2:0] Game_status;//3种游戏状态，START：001；PLAY：010；END：100；
	wire Hit_wall_sig;//撞墙信号
	wire Hit_body_sig;//撞到自己身体的信号
	wire Flash_sig;//闪动信号
	wire Restart_sig;//重新开始信号
	
	Game_ctrl_module U2(//游戏控制模块
		.Clk_24mhz(Clk_24mhz),
		.Rst_n(Rst_n),
		.Key_left(Key_left),
		.Key_right(Key_right),
		.Key_up(Key_up),
		.Key_down(Key_down),
		.Game_status(Game_status),
		.Hit_wall_sig(Hit_wall_sig),
		.Hit_body_sig(Hit_body_sig),
		.Flash_sig(Flash_sig)
	);
		
/***************************************************************************/
	
	wire [7:0] Apple_1;//苹果的坐标
	wire [7:0] Apple_2;//苹果的坐标
	wire [7:0] Apple_3;//苹果的坐标
	wire [7:0] Head;//蛇头部的坐标
	wire Body_add_sig;//身体节数增加信号

	Apple_generate_module U3(//苹果产生模块
		.Clk_24mhz(Clk_24mhz),
		.Rst_n(Rst_n),
		.Apple_1(Apple_1),
		.Apple_2(Apple_2),
		.Apple_3(Apple_3),
		.Head(Head),
		.Body_add_sig(Body_add_sig)
	);
	
/***************************************************************************/
	wire [6:0] Body_num;//身体节数，最多16，可改
	wire [7:0] BodyA;
	wire [7:0] BodyB;
	wire [7:0] BodyC;
	wire [7:0] BodyD;
	wire [7:0] BodyE;
	wire [7:0] BodyF;
	wire [7:0] BodyG;
	wire [7:0] BodyH;
	wire [7:0] BodyI;
	wire [7:0] BodyJ;
	wire [7:0] BodyK;
	wire [7:0] BodyL;
	wire [7:0] BodyM;
	wire [7:0] BodyN;
	wire [7:0] BodyO;
	wire [7:0] BodyP;
	wire [7:0] Snake_length;

	Snake_ctrl_module U4(//蛇运动控制模块
		.Clk_24mhz(Clk_24mhz),
		.Rst_n(Rst_n),
		.Key_left(Key_left),
		.Key_right(Key_right),
		.Key_up(Key_up),
		.Key_down(Key_down),
		.Head(Head),
		.Body_add_sig(Body_add_sig),
		.Game_status(Game_status),
		.Hit_body_sig(Hit_body_sig),
		.Hit_wall_sig(Hit_wall_sig),
		.Flash_sig(Flash_sig),
		.BodyA(BodyA),
		.BodyB(BodyB),
		.BodyC(BodyC),
		.BodyD(BodyD),
		.BodyE(BodyE),
		.BodyF(BodyF),
		.BodyG(BodyG),
		.BodyH(BodyH),
		.BodyI(BodyI),
		.BodyJ(BodyJ),
		.BodyK(BodyK),
		.BodyL(BodyL),
		.BodyM(BodyM),
		.BodyN(BodyN),
		.BodyO(BodyO),
		.BodyP(BodyP),
		.Snake_length(Snake_length)
	);	
	
/***************************************************************************/
	Key_check_module U6(//按键检测模块
		.Clk_10khz(Clk_10khz),
		.Rst_n(Rst_n),
		.Left(~Left),
		.Right(~Right),
		.Up(~Up),
		.Down(~Down),
		.Key_left(Key_left),
		.Key_right(Key_right),
		.Key_up(Key_up),
		.Key_down(Key_down)		
	);
	
/***************************************************************************/
	Smg_display_module U7(//数码管显示模块
		.Clk_24mhz(Clk_24mhz),
		.Rst_n(Rst_n),	
		.Body_add_sig(Body_add_sig),
		.Game_status(Game_status),
		.Smg_duan(Smg_duan),
		.Smg_we(Smg_we)
	);

	Array_decoder U8(
		.Clk(Clk_10khz),
		.rst(Rst_n),
		.BodyA(BodyA),
		.BodyB(BodyB),
		.BodyC(BodyC),
		.BodyD(BodyD),
		.BodyE(BodyE),
		.BodyF(BodyF),
		.BodyG(BodyG),
		.BodyH(BodyH),
		.BodyI(BodyI),
		.BodyJ(BodyJ),
		.BodyK(BodyK),
		.BodyL(BodyL),
		.BodyM(BodyM),
		.BodyN(BodyN),
		.BodyO(BodyO),
		.BodyP(BodyP),
		.Snake_length(Snake_length),
		.Apple_1(Apple_1),
		.Apple_2(Apple_2),
		.Apple_3(Apple_3),
		.Game_status(Game_status),
		.row(Array_row),
		.col(Array_col)
		);
	
endmodule
