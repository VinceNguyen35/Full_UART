`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Adrs_Decode.v                                                   //
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

module Adrs_Decode(
    input       [15:0]  port_ID,
    input               write_strobe,
    input               read_strobe,
    
    output  reg [7:0]   write,
    output  reg [7:0]   read
    );
    
    always @(*) begin
        //////////////////////////////////////////////////
        // 3 to 8 decoder for writing
        /////////////////////////////////////////////////
        if((port_ID[15] == 0) && (write_strobe == 1))
            case(port_ID[2:0])
                3'b000: write = 8'b0000_0001;
                3'b001: write = 8'b0000_0010;
                3'b010: write = 8'b0000_0100;
                3'b011: write = 8'b0000_1000;
                3'b100: write = 8'b0001_0000;
                3'b101: write = 8'b0010_0000;
                3'b110: write = 8'b0100_0000;
                3'b111: write = 8'b1000_0000;
                default: write = 8'b0000_0000;
            endcase
        else
            write = 8'b0000_0000;
        //////////////////////////////////////////////////
        // 3 to 8 decoder for reading
        /////////////////////////////////////////////////    
        if((port_ID[15] == 0) && (read_strobe == 1))
            case(port_ID[2:0])
                3'b000: read = 8'b0000_0001;
                3'b001: read = 8'b0000_0010;
                3'b010: read = 8'b0000_0100;
                3'b011: read = 8'b0000_1000;
                3'b100: read = 8'b0001_0000;
                3'b101: read = 8'b0010_0000;
                3'b110: read = 8'b0100_0000;
                3'b111: read = 8'b1000_0000;
                default: read = 8'b0000_0000;
            endcase
        else
            read = 8'b0000_0000;
    end        
endmodule
