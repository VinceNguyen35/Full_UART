`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Baud_Decode.v                                                   //
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

module Baud_Decode(
    input       [3:0]   BaudVal,
    output  reg [18:0]  k
    );
    
    always @(*)
        case(BaudVal)
            4'b0000 : k = 333333;
            4'b0001 : k = 83333;
            4'b0010 : k = 41667;
            4'b0011 : k = 20833;
            4'b0100 : k = 10417;
            4'b0101 : k = 5208;
            4'b0110 : k = 2604;
            4'b0111 : k = 1736;
            4'b1000 : k = 868;
            4'b1001 : k = 434;
            4'b1010 : k = 217;
            4'b1011 : k = 109;
            4'b1100 : k = 0;
            4'b1101 : k = 0;
            4'b1110 : k = 0;
            4'b1111 : k = 0;
            default: k = 0;
        endcase       
endmodule