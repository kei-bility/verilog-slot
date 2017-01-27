/* -----------------------------------------------------
 *  �����̌����N�����Ă���A�ׂ̌��̃J�E���^���N��������܂ł̎��ԑ҂�������
 *  �҂����킹����:7�N���b�N
 *  �J�E���g��~���...3'b000
 *  �^�C���A�E�g���... 3'b111
 *       (StartDelay.v)
 * ----------------------------------------------------- */
 
module StartDelay(clock, reset, trigger, timeOut);
    input clock;        // �N���b�N
    input reset;        // ���Z�b�g
    input trigger;      // �N���M��
    output timeOut;     // �^�C���A�E�g�M��
    
    reg [2:0] StartDelayCount;  // 3�r�b�g�̃J�E���^
    
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            StartDelayCount <= 0;       // ���Z�b�g����
        end else if (trigger) begin
            StartDelayCount <= 1;                       // 3'b001�ɂ���
        end else if (StartDelayCount) begin
            StartDelayCount <= StartDelayCount + 1;     // �J�E���g����
        end
    end
    
    // & ���Z�q�͑S�r�b�g��1���ǂ���
    // �܂�3'b111�̂Ƃ��^�C���A�E�g�̂���A�N�e�B�u��
    assign timeOut = & StartDelayCount;
    
endmodule