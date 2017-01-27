/* --------------------------------------------------- 
 *   8�i�J�E���^
 *   �������C�񓯊����Z�b�g�C�J�E���g�E�C�l�[�u�����͂�
 *   (Count8.v)
 * --------------------------------------------------�@*/

module Count8(clock, reset, enable, count);
    input clock, reset;     // �N���b�N�C���Z�b�g
    input enable;           // �J�E���g�E�C�l�[�u��
    output [2:0] count;     // �J�E���g�l
    
    // �L���@�\�̂���M��
    reg [2:0] count;
    
    // �G�b�W�E�g���K �񓯊����Z�b�g
    always @(posedge clock or negedge reset) begin
        if (!reset) begin
            count <= 3'b000;    // ���Z�b�g����
        end else if (enable) begin
            count <= count + 1;     // �J�E���g�A�b�v����
        end
    end
endmodule

            