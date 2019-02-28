
module DPA2(cout,final_sum,a,b,aluop,negative_flag,overflow_flag,zero_flag);

parameter N=32;

input [N-1:0] a,b;           //inputs
input [4:0] aluop;
output reg [N-1:0] final_sum;//output
output cout;
output reg negative_flag,overflow_flag;
output reg zero_flag;

reg cin = 0;

wire [N-1:0] p , g; 
wire [N:0] c;
wire [N-1:0] sum0 , sum1;
wire [N-1:0] sum;


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


//step5 : signed and unsigned interpretation and flags

always@(*)
begin
    if(aluop == 5'b00001 && sum[N-1])
    begin
        final_sum = ~(sum[N-1:0])+1;
        negative_flag = aluop == 00001 ? sum[N-1] : 1'b0;
        overflow_flag = (a[N-1] & b[N-1] & (~(final_sum[N-1])) |(~(a[N-1])) & (~(b[N-1])) & final_sum[N-1]);

    end
    else if (aluop == 5'b00010)
    begin
        final_sum = sum[N-1:0];
        negative_flag = 0;
        overflow_flag = cout;
    end

    else if (aluop == 5'b00011)
    begin
        final_sum = a + (~b + 1) ;
    end

    zero_flag = final_sum == 0;

end

endmodule

