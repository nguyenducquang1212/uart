/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2022 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: dti_arb_fcfs_assertion
 *     Project     : Verification Traning
 *     Author      : haint1
 *     Created     : 2022-10-01 11:04:18
 *     Description :
 *
 *     @Last Modified by:   
 *     @Last Modified time:
 *-----------------------------------------------------------------------------
 */
  module uart_sva (intf);
  uart_interface intf;

//  Check uart_transmitter
  property send_ack_p;
    @(posedge intf.clk) (intf.send_ack) |-> ( intf.din == intf.frame_tx);
  endproperty
  AP_SEND_ACK: assert property (send_ack_p);

//  Check uart_receiver
  property recv_req_p;
    @(posedge intf.clk) (intf.recv_req) |-> ( intf.dout == intf.rx_sample);
  endproperty
  AP_RECV_REQ: assert property (recv_req_p);

  endmodule