`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	D_Flop.v                                                        //
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

module D_Flop(
    input       clk,
    input       rst,
    input       D,
    output  reg Q
    );

    always @(posedge clk, posedge rst)
        if(rst) Q <= 1'b0;
        else    Q <= D;
endmodule
