`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Shift_Register_11Bit.v                                          //
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

module Shift_Register_11Bit(
    input           clk,
    input           rst,
    input           LD,
    input           SH,
    input           SDI,
    input           bit_10,
    input           bit_9,
    input           bit_1,
    input           bit_0,
    input   [6:0]   data,
    output          SDO
    );
    
    reg     [10:0]  Store;
    
    assign SDO = Store[0];
    
    always @(posedge clk, posedge rst) begin
        if(rst)         Store <= 11'b111_1111_1111;
        else if(LD)     Store <= {bit_10,bit_9,data,bit_1,bit_0};
        else if(SH)     Store <= {SDI,Store[10:1]};
        else            Store <= Store;
    end        
endmodule
