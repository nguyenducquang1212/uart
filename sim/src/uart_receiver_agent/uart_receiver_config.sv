/*
 *-----------------------------------------------------------------------------
 *     Copyright (C) 2022 by Dolphin Technology
 *     All right reserved.
 *
 *     Copyright Notification
 *     No part may be reproduced except as authorized by written permission.
 *
 *     Module/Class: uart_receiver_config
 *     Project     : Verification Traning
 *     Author      : haint1
 *     Created     : 2022-10-01 11:04:18
 *     Description :
 *
 *     @Last Modified by:   
 *     @Last Modified time:
 *-----------------------------------------------------------------------------
 */
//-------------------------------------------------------------------------------------------------
//  Class:uart_receiver_config
//  Every agent should have a configuration object that encapsulates all of the parameters that 
//  can be modified to control the agent's behavior.
//-------------------------------------------------------------------------------------------------
class uart_receiver_config extends uvm_object;
  `uvm_object_utils(uart_receiver_config)

//  Virtual interface holds the pointer to the Interface.
  virtual uart_interface vif;

//  Convenience value to define whether a component, usually an agent, is in active mode or
//  passive  mode.
  uvm_active_passive_enum is_active = UVM_ACTIVE;
  extern function new (string name = "uart_receiver_config");
  endclass

//-------------------------------------------------------------------------------------------------
//  Constructor:new
//  The new function is called as class constructor. On calling the new method it allocates the 
//  memory and returns the address to the class handle.
//-----------------------------------------------------------------------------------------------
  function uart_receiver_config::new(string name = "uart_receiver_config");
    super.new(name);
  endfunction:new
