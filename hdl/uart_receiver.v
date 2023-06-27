module uart_receiver
#(
  parameter DATA_SIZE       = 8                  ,
  parameter SAMPLE          = 16                 ,
  parameter BIT_COUNT_SIZE  = $clog2(DATA_SIZE+1)
)(
  input                      clk        ,    // Clock
  input                      reset_n    ,  // Asynchronous reset active low
  input                      en_sample  ,
  input                      rx         ,
  output reg [DATA_SIZE-1:0] dout       ,
  output reg                 recv_req   ,
  input                      recv_ack   
);

// -------------------------------------------------------------
// Signal Declaration
// -------------------------------------------------------------
reg [SAMPLE-1           : 0]  check_start       ; //
reg [$clog2(SAMPLE) -1  : 0]  count_sample      ; //
reg [$clog2(SAMPLE) -1  : 0]  center            ; //

reg [BIT_COUNT_SIZE - 1 : 0]  bit_count         ; // 
reg                           bit_count_done    ; // 
reg                           load_rx_shift_reg ; // 
reg                           clear             ; // 
wire                          start             ;


// -------------------------------------------------------------
// State Encoding
// -------------------------------------------------------------
localparam IDLE      = 2'b00,
           RECEIVING = 2'b01,
           WAIT_ACK  = 2'b10;

reg [1:0] state, next_state;

// -------------------------------------------------------------
// Data out
// -------------------------------------------------------------
always @(posedge clk or negedge reset_n) begin : proc_dout
  if(~reset_n) begin
    dout <= 0;
  end else if (en_sample & (state == RECEIVING) & (count_sample == center-1) & (bit_count != DATA_SIZE)) begin
    dout <= {rx, dout[DATA_SIZE-1:1]};
  end
end



// -------------------------------------------------------------
// Counter
// -------------------------------------------------------------

always @(posedge clk or negedge reset_n) begin : proc_check_start
  if(~reset_n) begin
    check_start <= '1;
  end else if (en_sample) begin
    check_start <= {rx, check_start[SAMPLE-1 : 1]};
  end
end

assign start = (~(|check_start[SAMPLE-1 : SAMPLE/2])) & (&check_start[SAMPLE/2-1 : 0]);

always @(posedge clk or negedge reset_n) begin : proc_count_sample
  if(~reset_n) begin
    count_sample <= 0;
  end else if (en_sample) begin
    count_sample <= (count_sample == SAMPLE-1) ? 0 : (count_sample + 1);
  end
end

always @(posedge clk or negedge reset_n) begin
  if(~reset_n) begin
    center <= 0;
  end else if (state == IDLE & start) begin
    center <= count_sample;
  end
end


always @(posedge clk or negedge reset_n) begin : proc_counter
  if(~reset_n) begin
    bit_count <= 0;
  end
  else if (state == RECEIVING) begin
    if(en_sample & (count_sample == (center-1))) begin
      bit_count <= bit_count + 1'b1;
    end
    else if (clear) begin
      bit_count <= 0;
    end
    else begin
      bit_count <= bit_count;
    end
  end
  else begin 
    bit_count <= 0;
  end
end

always @(*) begin : proc_count_done
  bit_count_done = (bit_count == (DATA_SIZE + 1));
end


// -------------------------------------------------------------
// FSM
// -------------------------------------------------------------
always @(posedge clk or negedge reset_n) begin : proc_state
  if(~reset_n) begin
    state <= IDLE;
  end
  else begin
    state <= next_state;
  end
end




// -------------------------------------------------------------
// FSM ouput signal
// -------------------------------------------------------------
always @(*) begin : proc_output_fsm
  load_rx_shift_reg = 0;
  clear = 0;
  recv_req = 0;
  case (state)
    IDLE: begin
      if (start) begin
        next_state = RECEIVING;
      end
    end
    RECEIVING: begin
      if (bit_count_done) begin
        clear = 1;
        next_state = WAIT_ACK;
      end
      else begin
        next_state = RECEIVING;
      end
    end
    WAIT_ACK: begin
      recv_req = 1;
      if(reset_n) begin
        if (recv_ack) begin
          next_state = IDLE;
        end
        else begin 
          next_state = WAIT_ACK;
        end
      end else begin
        recv_req = 0;
        next_state = IDLE;
      end
    end
    default : next_state = IDLE;
  endcase
end




endmodule