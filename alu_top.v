module alu_top #(parameter width = 32)
              (
               input [width - 1 : 0]in_1,
               input [width - 1 : 0]in_2,
               input [4:0]aluop,
               output reg [width - 1:0]alu_out,

               );
wire [width - 1:0] final_sum;
wire [width - 1:0] out_and;
wire [width - 1:0] out_or;
wire [width - 1:0] out_xor;
wire [width - 1:0] out_xnor;
wire [width - 1:0] out_nor;
wire [width - 1:0] out_nand;
wire [width - 1:0] out_not;
wire [width - 1:0] out_sll;
wire [width - 1:0] out_srl;
wire [width - 1:0] out_sar;
wire [width - 1:0] out_ror;
wire [width - 1:0] out_rol;


DPA2 dut1(.final_sum(final_sum),
          .cout(cout),
         .a(in_1),
         .b(in_2),
         .aluop(aluop),
         .negative_flag(negative_flag),
         .overflow_flag(overflow_flag),
         .zero_flag(zero_flag)
         );

AND dut2(.out_and(out_and),
        .in_1(in_1),
        .in_2(in_2)
        ); 

OR dut3(
        .out_or(out_or),
        .in_1(in_1),
        .in_2(in_2)
       ); 

XOR dut4( 
         .out_xor(out_xor),
         .in_1(in_1),
         .in_2(in_2)
        );
      
XNOR dut5(
          .out_xnor(out_xnor),
          .in_1(in_1),
          .in_2(in_2)
          );       

NAND dut6(
          .out_nand(out_nand),
          .in_1(in_1),
          .in_2(in_2)
          );          

NOT dut7(
         .out_not(out_not),
         .in_1(in_1)
         );

SLL dut8(
         .out_sll(out_sll),
         .in_1(in_1),
         .in_2(in_2)
         ); 

SRL dut9(
         .out_srl(out_srl),
         .in_1(in_1),
         .in_2(in_2)
         );

SAR dut10( 
          .out_sar(out_sar),
          .in_1(in_1),
          .in_2(in_2)
          ); 

ROL dut11(
          .out_rol(out_rol),
          .in_1(in_1),
          .in_2(in_2)
          ); 

ROR dut12(
          .out_ror(out_ror),
          .in_1(in_1),
          .in_2(in_2)
          );  
NOR dut13(
          .out_nor(out_nor),
          .in_1(in_1),
          .in_2(in_2)
          );
always@(*) 
begin
    case(aluop[4:0])
        5'b00001 : alu_out = final_sum;
        5'b00011 : alu_out = final_sum;
        5'b00101 : alu_out = out_and;
        5'b00110 : alu_out = out_or;
        5'b00111 : alu_out = out_xor;
        5'b01000 : alu_out = out_nand;
        5'b01001 : alu_out = out_nor;
        5'b01010 : alu_out = out_xnor;
        5'b01011 : alu_out = out_sll;
        5'b01100 : alu_out = out_srl;
        5'b01101 : alu_out = out_sar;
        5'b01110 : alu_out = out_ror;
        5'b01111 : alu_out = out_rol;
        5'b10000 : alu_out = out_not;
        default : alu_out = 32'd0;
    endcase

end
assign 


endmodule



