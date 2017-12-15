module Game_ctrl_module//游戏控制模块,根据游戏状态产生相应控制信号	
(
	input Clk_24mhz,
	input Rst_n,
	input Key_left,//左按键
	input Key_right,//右按键
	input Key_up,//上按键
	input Key_down,//下按键
	output reg  [2:0] Game_status,//3种游戏状态，START：001；PLAY：010；END：100；
	input Hit_wall_sig,//撞墙信号
	input Hit_body_sig,//撞到自己的身体信号
	output reg Flash_sig//FLASH信号
);
	//3种游戏状态	
	parameter START = 3'b001;
	parameter  PLAY = 3'b010;
	parameter   END = 3'b100;

	always @ (posedge Clk_24mhz or negedge Rst_n)
	begin
		if(!Rst_n)
		begin
			Game_status <= START;;//复位的时候，送START状态
			Flash_sig <= 1'd1;
		end
		else
		begin
			Game_status <= START;
			case(Game_status)//选择游戏状态
				START://在START状态里，有任意一个按键按下，则送PLAY状态
					begin	
						if(Key_left | Key_right | Key_up | Key_down)
						begin		
							Game_status <= PLAY;
						end
						else
							Game_status <= START;//避免生成锁存器
					end 
				PLAY://PLAY状态，如果撞墙或者碰到身体，送END状态
					begin
						if(Hit_wall_sig | Hit_body_sig)
						begin		
							Game_status <= END;
						end
						else
							Game_status <= PLAY;
					end
				END://END状态，游戏结束的时候，出现一段蛇身体闪动的画面
					begin
						if(Key_left | Key_right | Key_up | Key_down)
						begin
							Game_status <= START;
							Flash_sig <= 1'd1;//一直是亮的
						end
						else
						begin
							Game_status <= END;
							Flash_sig <= 1'd1;//一直是亮的
						end		
					end
			endcase
		end
	end
endmodule
	
