`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Right_Justify.v                                                 //
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

module Right_Justify(
    input       [9:0]   Q,
    input               EIGHT,
    input               PEN,
    output  reg [9:0]   Q_Out
    );
    
    always @(*)
        if((EIGHT && ~PEN) || (~EIGHT && PEN))
            Q_Out = {1'b1, Q[9:1]};
        else if(~EIGHT && ~PEN)
            Q_Out = {2'b11, Q[9:2]};
        else
            Q_Out = Q;
endmodule
