`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Datapath_Decode.v                                               //
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

module Datapath_Decode(
    input           EIGHT,
    input           PEN,
    input           OHEL,
    input   [7:0]   data,
    output  reg     bit_10,
    output  reg     bit_9
    );
    
    always @(*) begin
        case({EIGHT,PEN,OHEL})
            3'b000 : {bit_10,bit_9} = 2'b11;
            3'b001 : {bit_10,bit_9} = 2'b11;
            3'b010 : {bit_10,bit_9} = {1'b1,^data[6:0]};
            3'b011 : {bit_10,bit_9} = {1'b1,~^data[6:0]};
            3'b100 : {bit_10,bit_9} = {1'b1,data[7]};
            3'b101 : {bit_10,bit_9} = {1'b1,data[7]};
            3'b110 : {bit_10,bit_9} = {^data[7:0],data[7]};
            3'b111 : {bit_10,bit_9} = {~^data[7:0],data[7]};
            default: {bit_10,bit_9} = 2'b00;
        endcase
    end        
endmodule