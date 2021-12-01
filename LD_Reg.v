`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	LD_Reg.v                                                        //
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

module LD_Reg(
    input               clk,
    input               rst,
    input               load,
    input       [7:0]   D,
    output  reg [7:0]   Q
    );
    
    always @(posedge clk, posedge rst)
        if(rst)         Q <= 8'b0;
        else if(load)   Q <= D;
        else            Q <= Q;
endmodule
