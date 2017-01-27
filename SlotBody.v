/* ---------------------------------------------------
 *  スロットマシン本体
 *  カウンタ、スタートストップシーケンサー、スタートディレイのインスタンス化
 *  (SlotBody.v)
 * ------------------------------------------------- */
 
module SlotBody(clock, /*reset*/, start, stop, left, middle, right, run_stop, fever);
    
    input clock;
    //input reset;
    input start;
    input [2:0] stop;
    output [2:0] left, middle, right;
    output run_stop;    // ゲームの状態を示す
    output fever;       // 全桁のカウ・E・タ値が一致している
    
    wire runLeft, runMiddle, runRight;
    wire timeOut1, timeOut2;
    wire startTrigger;
    reg startD, startDD;
	 
	 reg reset;
    
    // チャタリング除去とプッシュ・スイッチが押された直後の1クロック間だけパルスを発生する回路を経由して
    // startTrigger信号を生成し、必要なモジュールに接続
    /*
    always @(negedge clock) begin
        startD <= start;
        startDD <= start_DD;
    end
    */
    
    //assign startTrigger = startD & ~startDD;
    
    // 3個のカウンタのインスタンス化
    Count8 L(clock, reset, runLeft, left);
    Count8 M(clock, reset, runMiddle, middle);
    Count8 R(clock, reset, runRight, right);
    
    // ・X・^ートストップシーケンサーのインスタンス化
    StartStopSequencer LS(clock, reset, startTrigger, (run_stop & startTrigger), stop[2], runLeft);
    StartStopSequencer MS(clock, reset, startTrigger, timeOut1, stop[1], runMiddle);
    StartStopSequencer RS(clock, reset, startTrigger, timeOut2, stop[0], runRight);
    
    // スタートディレイのインスタンス化
    StartDelay T1(clock, reset, (~run_stop & startTrigger), timeOut1);
    StartDelay T2(clock, reset, timeOut1, timeOut2);
    
    // 全部あたってるか・ﾇ・､かのチェック
    assign run_stop = runLeft | runMiddle | runRight;
    assign fever = (left == middle) && (left == right);
	 
	 always @(posedge clock) begin
	     if (fever) begin
		      reset <= 1'b1;
		  end else begin
				reset <= 1'b0;
		  end
		  
	 end
endmodule
