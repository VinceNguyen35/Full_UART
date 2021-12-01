`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Shift_Register_10Bit.v                                          //
//  Project:	CECS 460 Project 4: Full UART                                   //
//                                                                              //
//	Created by Vince Nguyen on May 11, 2020                                     //
//  Copyright © 2020 Vince Nguyen.  All rights reserved.                        //
//                                                                              //
//  In submitting this file for class work at CSULB I am confirming that this   //
//  is my work and the work of no one else.  In submitting this code I          //
//  acknowledge that plagiarism in student project work is subject to dismissal //
//  from the class.                                                             //
//                                                                              //
//******************************************************************************//

module Shift_Register_10Bit(
    input               clk,
    input               rst,
    input               SHIFT,
    input               SDI,
    output  reg [9:0]   Q
    );
    
    always @(posedge clk, posedge rst) begin
        if(rst)         Q <= 10'b00_0000_0000;
        else if(SHIFT)  Q <= {SDI, Q[9:1]};
        else            Q <= Q;
    end        
endmodule
