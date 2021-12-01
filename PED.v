`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	PED.v                                                           //
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


module PED(
    input   clk,
    input   rst,
    input   D,
    output  out
    );
    
    reg     Q1,Q2;
    
    assign out = (Q1 && ~Q2);
    
    always @(posedge clk, posedge rst)
        if(rst) begin
            Q1 <= 1'b0;
            Q2 <= 1'b0;  
        end
        else    begin
            Q1 <= D;
            Q2 <= Q1;
        end  
endmodule
