/* ---------------------------------------------------
 *  �X���b�g�}�V���{��
 *  �J�E���^�A�X�^�[�g�X�g�b�v�V�[�P���T�[�A�X�^�[�g�f�B���C�̃C���X�^���X��
 *  (SlotBody.v)
 * ------------------------------------------------- */
 
module SlotBody(clock, /*reset*/, start, stop, left, middle, right, run_stop, fever);
    
    input clock;
    //input reset;
    input start;
    input [2:0] stop;
    output [2:0] left, middle, right;
    output run_stop;    // �Q�[���̏�Ԃ�����
    output fever;       // �S���̃J�E�EE�E�^�l����v���Ă���
    
    wire runLeft, runMiddle, runRight;
    wire timeOut1, timeOut2;
    wire startTrigger;
    reg startD, startDD;
	 
	 reg reset;
    
    // �`���^�����O�����ƃv�b�V���E�X�C�b�`�������ꂽ�����1�N���b�N�Ԃ����p���X�𔭐������H���o�R����
    // startTrigger�M���𐶐����A�K�v�ȃ��W���[���ɐڑ�
    /*
    always @(negedge clock) begin
        startD <= start;
        startDD <= start_DD;
    end
    */
    
    //assign startTrigger = startD & ~startDD;
    
    // 3�̃J�E���^�̃C���X�^���X��
    Count8 L(clock, reset, runLeft, left);
    Count8 M(clock, reset, runMiddle, middle);
    Count8 R(clock, reset, runRight, right);
    
    // �EX�E^�[�g�X�g�b�v�V�[�P���T�[�̃C���X�^���X��
    StartStopSequencer LS(clock, reset, startTrigger, (run_stop & startTrigger), stop[2], runLeft);
    StartStopSequencer MS(clock, reset, startTrigger, timeOut1, stop[1], runMiddle);
    StartStopSequencer RS(clock, reset, startTrigger, timeOut2, stop[0], runRight);
    
    // �X�^�[�g�f�B���C�̃C���X�^���X��
    StartDelay T1(clock, reset, (~run_stop & startTrigger), timeOut1);
    StartDelay T2(clock, reset, timeOut1, timeOut2);
    
    // �S���������Ă邩�EǁE����̃`�F�b�N
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
