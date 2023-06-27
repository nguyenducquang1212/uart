module uart_gen_clk #(
  parameter SYS_FREQ  = 50000000                   ,
  parameter BAUD_RATE = 9600                       ,
  parameter SAMPLE    = 16                         ,
  parameter CLOCK     = SYS_FREQ/(BAUD_RATE)       ,
  parameter BAUD_DV   = SYS_FREQ/(SAMPLE*BAUD_RATE)
)(
  input        clk       ,    // Clock
  input        reset_n   ,  // Asynchronous reset active low
  // output reg   en        ,
  output reg   en_sample
);


  // reg [$clog2(CLOCK  ) - 1 : 0] count_clk;
  // always @(posedge clk or negedge reset_n) begin
  //   if(~reset_n) begin
  //     count_clk <= 0;
  //   end else begin
  //     count_clk <= (count_clk == (CLOCK - 1) ? 0 : (count_clk + 1));
  //   end
  // end

  reg [$clog2(BAUD_DV) - 1 : 0] count_sample_clk;
  always @(posedge clk or negedge reset_n) begin
    if(~reset_n) begin
      count_sample_clk <= 0;
    end else begin
      count_sample_clk <= (count_sample_clk == (BAUD_DV - 1) ? 0 : (count_sample_clk + 1));
    end
  end

  // always @(posedge clk or negedge reset_n) begin
  //   if(~reset_n) begin
  //     en <= 1'b0;
  //   end else if (count_clk == (CLOCK - 1)) begin
  //     en <= 1'b1;
  //   end
  //   else begin 
  //     en <= 1'b0;
  //   end
  // end

  always @(posedge clk or negedge reset_n) begin : proc_en_sample
    if(~reset_n) begin
      en_sample <= 1'b0;
    end else if (count_sample_clk == (BAUD_DV - 1)) begin
      en_sample <= 1'b1;
    end
    else begin 
      en_sample <= 1'b0;
    end
  end


endmodule