
module DPA2_tb;

parameter N = 32;

reg [N-1:0] a,b;
reg [4:0] alu_op;
wire [N-1:0] final_sum;
wire cout;
wire negative_flag,overflow_flag;
wire zero_flag;

DPA2 uut(.negative_flag(negative_flag),
         .overflow_flag(overflow_flag),
         .zero_flag(zero_flag),
         .a(a),
         .b(b),
         .alu_op(alu_op),
         .cout(cout),
         .final_sum(final_sum));

initial
begin
    alu_op = 5'b00001;
    a = -100;
    b =  -50;
#10
    alu_op = 5'b00010;
    a = 100;
    b = 20;
#20
    alu_op = 5'b00011;
    a = 50;
    b = 70;
#200
$finish();

end

initial 
begin
    $shm_open("DPA2.shm");
    $shm_probe("ACTMF");
end
endmodule

