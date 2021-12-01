`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	AISO.v                                                          //
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

module AISO(
    input   clk,
    input   rst,
    output  Reset_S
    );
    
    reg    Qok, Qmeta;
    
    assign  Reset_S = ~Qok;
    
    always @(posedge clk, posedge rst)
        if(rst) begin
            Qmeta <= 1'b0;
            Qok <= 1'b0;
        end
        else    begin
            Qmeta <= 1'b1;
            Qok <= Qmeta;
        end
endmodule