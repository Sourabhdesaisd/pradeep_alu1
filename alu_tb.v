
module alu_tb();

reg [31:0] in_1;
reg [31:0] in_2;
reg [4:0] aluop;
wire [31:0] alu_out;

alu_top alu_tb(
               .alu_out(alu_out),
               .in_1(in_1),
               .in_2(in_2),
               .aluop(aluop)
         //      .alu_out(alu_out)
                );


initial 
begin
    in_1=32'd0;
    in_2=32'd0;
    aluop=5'b00000;

#10;
in_1=32'b0000_0000_0000_0101;
in_2=32'b0000_0000_0000_0110;
aluop=5'b00001;

#10;
aluop=5'b00010;

#10;
aluop=5'b00101;

#10;
aluop=5'b00110;

#10;
aluop=5'b00111;

#10;
aluop=5'b01000;

#10;
aluop=5'b01001;

#10;
aluop=5'b01010;

#10;
aluop=5'b01011;

#10;
aluop=5'b01100;

#10;
aluop=5'b01101;

#10;
aluop=5'b01110;

#10;
aluop=5'b01111;

#10;
aluop=5'b10000;

#10;
in_1=32'b0000_0000_0000_0101;
in_2=32'd5;
aluop=5'b00001;

#10;
aluop=5'b00010;

#10;
aluop=5'b00101;

#10;
aluop=5'b00110;

#10;
aluop=5'b00111;

#10;
aluop=5'b01000;

#10;
aluop=5'b01001;

#10;
aluop=5'b01010;

#10;
aluop=5'b01011;

#10;
aluop=5'b01100;

#10;
aluop=5'b01101;

#10;
aluop=5'b01110;

#10;
aluop=5'b01111;

#10;
aluop=5'b10000;
end


initial
begin
    $shm_open("wave.shm");
    $shm_probe("ACTMF");
    #1000 $finish;
end


endmodule





