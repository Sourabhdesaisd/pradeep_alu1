module ALU(cout,final_sum,a,b,aluop,negative_flag,overflow_flag,zero_flag);

parameter N=32;

input [N-1:0] a,b;           //inputs
input [4:0] aluop;
 output reg [N-1:0] final_sum;//final_sumput
output reg negative_flag,overflow_flag;
output reg zero_flag;
output cout;

reg cin = 0;

wire [N-1:0] p , g; 
wire [N:0] c;
wire [N-1:0] sum0 , sum1;
wire [N-1:0] sum;

wire [30:0] sar = b[30:0] >> b ;


//step1 : propagate and generate signals

assign p = a ^ b;
assign g = a & b;

//step2 : sum precomputation

assign sum0 = p;
assign sum1 = ~(p);

//step3 : carry generation

assign c[0] = cin;

genvar i;
generate
for(i = 0; i<N ; i = i+1)
begin:carry_logic    
assign c[i+1] = g[i] |( p[i] & c[i]);
end
endgenerate

assign cout = c[N];

//step4 : final sum logic

genvar j;
generate
for(j = 0; j<N ; j = j+1)
begin:sum_logic
assign sum[j] = c[j] ? sum1[j] : sum0[j];
end
endgenerate




/////////////////////////////////////////////////////////ALU///////////////////////////////////////////////////////////////////////
//step5 : signed and unsigned interpretation and flags

always@(*)
begin
    case(aluop)
        5'b00001 : ////ADD signed 
                if(aluop == 5'b00001 && sum[N-1])
                 begin
                    final_sum = ~(sum[N-1:0])+1;
                    negative_flag = aluop == 00001 ? sum[N-1] : 1'b0;
                    overflow_flag = (a[N-1] & b[N-1] & (~(final_sum[N-1])) |(~(a[N-1])) & (~(b[N-1])) & final_sum[N-1]);
                    zero_flag = final_sum == 0;

                 end

       5'b00010 :  ///ADD unsigned
                begin
                 final_sum = sum[N-1:0];
                 negative_flag = 0;
                 overflow_flag = cout;
                 zero_flag = final_sum == 0;
                end

       5'b00011 : ///SUB
                 begin
                 final_sum = a + (~b + 1) ;
                 end

      5'b00100: /// MUL
               begin
                 final_sum = 16'h0000_0000;
               end

      5'b00101 : ///SMUL
                 begin
                     final_sum = 16'h0000_0000;
                 end

      5'b00110 : ///div
                 begin
                     final_sum = a / b;
                 end

      5'b00111 : //IDIV
                 begin
                     final_sum =  16'h0000_0000;

                 end
      5'b01000 : //AND
                 begin
                     final_sum = a & b;
                 end

      5'b01001 : //OR
                 begin
                     final_sum = a | b;
                 end
      5'b01010 : //XOR
                 begin
                     final_sum = a ^ b;
                 end
      5'b01011 : //NAND
                 begin
                     final_sum = ~(a & b);
                 end
      5'b01100 : //NOR
                 begin
                     final_sum = ~(a | b);
                 end
      5'b01101 : //XNOR
                 begin
                     final_sum = ~(a ^ b);
                 end
      5'b01110 : //SLL
                 begin
                     final_sum = a<<b;
                 end
      5'b01111 : //SRL
                 begin
                     final_sum = a>>b;
                 end
      5'b10000 : //SAR
                 begin
                     final_sum = {a[31:0],sar} ;
                 end

      5'b10001 : //ROR
                 begin
                    case(b[4:0])

                         5'b00000 : final_sum = a;

                         5'b00001 : final_sum = {a[0],a[31:1]};

                         5'b00010 : final_sum = {a[1:0],a[31:2]};

                         5'b00011 : final_sum = {a[2:0],a[31:3]};

                         5'b00100 : final_sum = {a[3:0],a[31:4]};

                         5'b00101 : final_sum = {a[4:0],a[31:5]};

                         5'b00110 : final_sum = {a[5:0],a[31:6]};

                         5'b00111 : final_sum = {a[6:0],a[31:7]};

                         5'b01000 : final_sum = {a[7:0],a[31:8]};

                         5'b01001 : final_sum = {a[8:0],a[31:9]};

                         5'b01010 : final_sum = {a[9:0],a[31:10]};

                         5'b01011 : final_sum = {a[10:0],a[31:11]};

                         5'b01100 : final_sum = {a[11:0],a[31:12]};

                         5'b01101 : final_sum = {a[12:0],a[31:13]};

                         5'b01110 : final_sum = {a[13:0],a[31:14]};

                         5'b01111 : final_sum = {a[14:0],a[31:15]};

                         5'b10000 : final_sum = {a[15:0],a[31:16]};

                         5'b10001 : final_sum = {a[16:0],a[31:17]};

                         5'b10010 : final_sum = {a[17:0],a[31:18]};

                         5'b10011 : final_sum = {a[18:0],a[31:19]};

                         5'b10100 : final_sum = {a[19:0],a[31:20]};

                         5'b10101 : final_sum = {a[20:0],a[31:21]};

                         5'b10110 : final_sum = {a[21:0],a[31:22]};

                         5'b10111 : final_sum = {a[22:0],a[31:23]};

                         5'b11000 : final_sum = {a[23:0],a[31:24]};

                         5'b11001 : final_sum = {a[24:0],a[31:25]};

                         5'b11010 : final_sum = {a[25:0],a[31:26]};

                         5'b11011 : final_sum = {a[26:0],a[31:27]};

                         5'b11100 : final_sum = {a[27:0],a[31:28]};

                         5'b11101 : final_sum = {a[28:0],a[31:29]};

                         5'b11110 : final_sum = {a[29:0],a[31:30]};

                         5'b11111 : final_sum = {a[30:0],a[31]};

                  endcase

                 end

        5'b10010 : begin //ROL

                    case(b[4:0])

                         5'b00000 : final_sum = a;

                         5'b00001 : final_sum = {a[30:0],a[31]};

                         5'b00010 : final_sum = {a[29:0],a[31:30]};

                         5'b00011 : final_sum = {a[28:0],a[31:29]};

                         5'b00100 : final_sum = {a[27:0],a[31:28]};

                         5'b00101 : final_sum = {a[26:0],a[31:27]};

                         5'b00110 : final_sum = {a[25:0],a[31:26]};

                         5'b00111 : final_sum = {a[24:0],a[31:25]};

                         5'b01000 : final_sum = {a[23:0],a[31:24]};

                         5'b01001 : final_sum = {a[22:0],a[31:23]};

                         5'b01010 : final_sum = {a[21:0],a[31:22]};

                         5'b01011 : final_sum = {a[20:0],a[31:21]};

                         5'b01100 : final_sum = {a[19:0],a[31:20]};

                         5'b01101 : final_sum = {a[18:0],a[31:19]};

                         5'b01110 : final_sum = {a[17:0],a[31:18]};

                         5'b01111 : final_sum = {a[16:0],a[31:17]};

                         5'b10000 : final_sum = {a[15:0],a[31:16]};

                         5'b10001 : final_sum = {a[14:0],a[31:15]};

                         5'b10010 : final_sum = {a[13:0],a[31:14]};

                         5'b10011 : final_sum = {a[12:0],a[31:13]};

                         5'b10100 : final_sum = {a[11:0],a[31:12]};

                         5'b10101 : final_sum = {a[10:0],a[31:11]};

                         5'b10110 : final_sum = {a[9:0],a[31:10]};

                         5'b10111 : final_sum = {a[8:0],a[31:9]};

                         5'b11000 : final_sum = {a[7:0],a[31:8]};

                         5'b11001 : final_sum = {a[6:0],a[31:7]};

                         5'b11010 : final_sum = {a[5:0],a[31:6]};

                         5'b11011 : final_sum = {a[4:0],a[31:5]};

                         5'b11100 : final_sum = {a[3:0],a[31:4]};

                         5'b11101 : final_sum = {a[2:0],a[31:3]};

                         5'b11110 : final_sum = {a[1:0],a[31:2]};

                        5'b11111 : final_sum = {a[0],a[31:1]};

                     endcase
                end
        5'b10011 : //NOT
                final_sum = ~a;
        
             endcase
end

endmodule

