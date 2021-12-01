`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Counter_Done.v                                                  //
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

module Counter_Done(
    input           clk,
    input           rst,
    input           BTU,
    input           doit,
    input   [3:0]   fx,
    output          DONE
    );
    
    reg     [3:0]   Q;
    wire    [3:0]   D;

    always @(posedge clk, posedge rst)
        if(rst)
            Q <= 4'b0;
        else
            Q <= D;
    
    assign DONE = (Q == fx) ? 1'b1 : 1'b0;
    
    assign D =  ({doit,BTU} == 2'b00) ? 4'b0:
                ({doit,BTU} == 2'b01) ? 4'b0:
                ({doit,BTU} == 2'b10) ? Q:
                                        Q + 4'b1;
endmodule