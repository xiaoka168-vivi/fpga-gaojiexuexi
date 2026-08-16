`timescale 1ns / 1ps

module key_filiter_tb;

  reg  Clk;
  reg  Reset_n;
  reg  Key;
  wire Key_P_Flag;
  wire Key_R_Flag;

  initial Clk = 0;
  always #10 Clk = ~Clk;

  key_filiter key_filiter_inst (
      .Clk(Clk),
      .Reset_n(Reset_n),
      .Key(Key),
      .Key_P_Flag(Key_P_Flag),
      .Key_R_Flag(Key_R_Flag)
  );


  initial begin
    Reset_n = 0;
    Key = 1;
    #201;
    Reset_n = 1;

    #100000000;  // 空闲稳定 100ms

    // 按下抖动
    Key = 0;
    #18000000;
    Key = 1;
    #2000000;
    Key = 0;
    #1000000;
    Key = 1;
    #2000000;
    Key = 0;
    #20000000;  // 低稳定 20ms
    #50000000;  // 保持按下

    // 释放抖动
    Key = 1;
    #2000000;
    Key = 0;
    #1000000;
    Key = 1;
    #20000000;  // 高稳定 20ms
    #50000000;  // 保持释放

    $stop;
  end

endmodule
