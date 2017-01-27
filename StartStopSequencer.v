/* -----------------------------------------------------
 *  StartStopSequencer
 *  3��Ԃ�p�ӂ��āA�Ή�����J�E���^�̓��쐧�������
 *  STOP:���Z�b�g������Ƃ��Q�[���̏I���
 *  WAIT:�Q�[�����n�܂��ăJ�E���^�̓�����n�߂�܂�
 *  RUN:�J�E���^�����쒆
 * ----------------------------------------------------- */
 
 // 3��Ԃ̒萔
`define STOP 2'b00
`define WAIT 2'b01
`define RUN  2'b10
 
module StartStopSequencer(clock, reset, start, run, stop, running);
    input clock;        // �N���b�N
    input reset;        // ���Z�b�g
    input start;        // �Q�[���J�n
    input run;          // ���N�E�
    input stop;         // ���X�g�b�v
    output running;     // ���ꂪ����8�i�J�E���^�ւ�enable�M���ɂ���run��Ԃ�\���M��
    
    
    wire clock, reset;
    wire start, run, stop;  // �X�^�[�g�X�C�b�`����̐M����start��run�ɐڑ�
    wire running;   
    reg [1:0] currState;    // 2�r�b�g�ŕ\�������݂̏��(S/W/R)
    
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            currState <= `STOP;
        end else if ((currState == `STOP) && start) begin
            if (~run) begin     // �����N�����ĂȂ�
                currState <= `WAIT;
            end else begin      // ���������Ă�
                currState <= `RUN;
            end
        end else if ((currState == `WAIT) && run) begin
            currState <= `RUN;      // �����Ԃɂ���
        end else if ((currState == `RUN) && `STOP) begin
            currState <= `STOP;     // �X�g�b�v��Ԃɂ���
        end
    end
    
    assign running = (currState == `RUN);
endmodule

