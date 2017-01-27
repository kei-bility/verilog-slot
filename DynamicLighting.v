/* -----------------------------------------------------
 *  �_�C�i�~�b�N�_���p�N���b�N���g����3�i�J�E���^���J�E���g�����āA
 *  �\�����錅�̑I���ƁA�_���̎w��M��(�ǂ��\������悤�ɂ��邩)�𑗂�
 *       (DynamicLighting.v)
 * ----------------------------------------------------- */
 
module DynamicLighting(dynamicClock, left, middle, right, digit, dynamicDigit);
    input dynamicClock;  // �_�C�i�~�b�N�_���p�̃N���b�N(Hz)
                         // ��̃��W���[��������炤
    input [2:0] left, middle, right;    // ������3���邤���ō��A�^�񒆁A�E�Ɗ���U��
    output [3:0] digit;
    output [2:0] dynamicDigit;  // ���EA�^�񒆁A�E�̂ǂ��_������悤�ɂ��邩
                                // ���ꂪ�p�^�[���̃f�R�[�_�ɓ�������
    reg [2:0] dynamicCount;
    
    // �_�C�i�~�b�N�_���p�̐���J�E���^
    // 00->01->10->00 ... ����Ȋ���
    always @(posedge dynamicClock) begin
        if (dynamicCount == 2'b10) begin
            dynamicCount <= 2'b00;  // 10�ɂȂ����烊�Z�b�g
        end else begin
            dynamicCount <= dynamicCount + 1;   // �J�E���g����
        end
    end
    
    // �\�����̑I��
    assign digit = (dynamicCount == 2'b00) ? 4'b0001:
                   (dynamicCount == 2'b01) ? 4'b0010:
                   (dynamicCount == 2'b10) ? 4'b0100: 4'b0000;
                   
    // ���A�^�񒆁A�E�̂ǂ��\�������邩�̑I��
    // ���Ƃ̓p�^�[���f�R�[�_�ɓ�����
    assign dynamicDigit = (dynamicCount == 2'b00) ? right:
                          (dynamicCount == 2'b01) ? middle:
                          (dynamicCount == 2'b10) ? left: 3'b111;
                   
 endmodule
 