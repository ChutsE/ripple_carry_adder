
module full_adder(
    output wire cout, sum,    
    input wire a, b, cin
);

    wire t;
    
    assign t = a^b;
    assign cout = (cin & t) | (a & b);
    assign sum = t^cin;
    
endmodule
