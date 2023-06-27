//  2) Use of Include Guards
//`ifndef _uart_if_INCLUDED_
//`define _uart_if_INCLUDED_

// interface uart_interface
// #(
//   parameter SYS_FREQ        = 50000000           ,
//   parameter BAUD_RATE       = 9600               ,
//   parameter SAMPLE          = 16                 ,
//   parameter DATA_SIZE       = 8                  ,
//   parameter BIT_COUNT_SIZE  = $clog2(DATA_SIZE+1)
// )
//     (input reset_n);
//   logic clk;
//   logic tx;
//   logic rx;
//   logic en;
//   logic en_sample;
//   logic [DATA_SIZE-1:0] din;
//   logic [DATA_SIZE-1:0] dout;
//   logic [DATA_SIZE-1:0] frame_rx;
//   logic [DATA_SIZE-1:0] frame_tx;
//   logic send_req;
//   logic send_ack;
//   logic recv_req;
//   logic recv_ack;
//   real bit_time = (SYS_FREQ/BAUD_RATE);
// endinterface

interface uart_interface
#(
  parameter SYS_FREQ        = 50000000           ,
  parameter BAUD_RATE       = 9600               ,
  parameter SAMPLE          = 16                 ,
  parameter DATA_SIZE       = 8                  ,
  parameter BIT_COUNT_SIZE  = $clog2(DATA_SIZE+1)
)
    (input clk);
  logic reset_n;
  logic tx;
  logic rx;
  logic en;
  logic en_sample;
  logic [DATA_SIZE-1:0] din;
  logic [DATA_SIZE-1:0] dout;
  logic [DATA_SIZE-1:0] rx_sample;
  logic [DATA_SIZE-1:0] frame_tx;
  logic send_req;
  logic send_ack;
  logic recv_req;
  logic recv_ack;
  real bit_time = (SYS_FREQ/BAUD_RATE);
endinterface







