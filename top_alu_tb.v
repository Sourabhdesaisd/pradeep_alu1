module test();
 parameter N=32;

reg [N-1:0] a,b;           //inputs
reg [4:0] aluop;
wire [N-1:0] final_sum;//final_sumput
wire negative_flag,overflow_flag;
wire zero_flag;
wire cout;

ALU dut(.cout(cout),
        .final_sum(final_sum),
        .a(a),
        .b(b),
        .aluop(aluop),
        .negative_flag(negative_flag),
        .overflow_flag(overflow_flag),
        .zero_flag(zero_flag));


initial begin
    $shm_open("Top.shm");
    $shm_probe("ACTMF");
end

initial begin
        aluop = 5'b00001 ; //ADD
        a = -100;
        b = 50;
#50
        aluop = 5'b00010 ; //ADDU
        a = 100;
        b = 50; 
#50
        aluop = 5'b00011 ; //SUB
        a = 1;
        b = 5;
#50
        aluop = 5'b00100 ; //MUL
        a = 5;
        b = 1;
#50
        aluop = 5'b00101 ; //SMUL
        a = 1;
        b = 2;
#50
        aluop = 5'b00110 ; //div
        a = 1;
        b = 2;
#50
        aluop = 5'b00111 ; //idiv
        a = 1;
        b = 2;
#50
        aluop = 5'b01000 ; //AND
        a = 1;
        b = 2;

#50
        aluop = 5'b01001 ; //OR
        a = 1;
        b = 2;
#50
        aluop = 5'b01010 ; //XOR
        a = 1;
        b = 2;
#50
        aluop = 5'b01011 ; //NAND
        a = 1;
        b = 2;
#50
        aluop = 5'b01100 ; //NOR
        a = 1;
        b = 2;
#50
        aluop = 5'b01101 ; //XNOR
        a = 1;
        b = 2;
#50
        aluop = 5'b01110 ; //SLL
        a = 1;
        b = 2;
#50
        aluop = 5'b01111 ; //SRL
        a = 1;
        b = 2;
#50
        aluop = 5'b10000 ; //SAR
        a = 1;
        b = 2;
#50
        aluop = 5'b10001 ; //ROR
        a = 1;
        b = 2;
#50
        aluop = 5'b10010 ; //ROL
        a = 1;
        b = 2;
#50
        aluop = 5'b10011 ; //SMUL
        a = 1;
#1000
 $finish();
end
endmodule
