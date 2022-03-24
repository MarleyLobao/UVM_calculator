# Calculator

## **Module Description**

*Calculator* is a simple design, non-synthesizable written for UVM-study purposes.
The following image, depicts the block interface, followed by its ports description. 

![Block Diagram](figs/calculator_bd.png)

| Portname        | Direction | Note |
| --------        | --------- | -----
| clk             | input     | clock
|rst_n            | input     | async, active-low
|function_in[1:0] | input     | opcodes are: <br /> 00 = SUM A+B <br /> 01 = SUB A-B <br /> 10 MUL = A\*B <br /> 11 = DIV A/B
|dat_a_in[7:0]    | input | signed 8-bit numbers [-128,127]
|dat_b_in[7:0]    | input | signed 8-bit numbers [-128,127]
|out[15:0]        | ouput | signed 16-bit numbers [-32'768,32'767]


