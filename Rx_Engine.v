`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Rx_Engine.v                                                     //
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

module Rx_Engine(
    input           clk,
    input           rst,
    input           RX,
    input           EIGHT,
    input           PEN,
    input           OHEL,
    input           Read,
    input   [18:0]  k,
    output  [7:0]   UART_RDATA,
    output  [2:0]   RX_Status,
    output  wire    RXRDY
    );
    
    wire    BTU, start, DONE, PERR, FERR, OVF;
    
    Rx_Engine_Control control
        (
        .clk(clk),
        .rst(rst),
        .RX(RX),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .k(k),
        .BTU(BTU),
        .DONE(DONE),
        .start(start)
        );
        
    Rx_Engine_Datapath datapath
        (
        .clk(clk),
        .rst(rst),
        .RX(RX),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .OHEL(OHEL),
        .BTU(BTU),
        .start(start),
        .Read(Read),
        .DONE(DONE),
        .RXRDY(RXRDY),
        .PERR(PERR),
        .FERR(FERR),
        .OVF(OVF),
        .UART_RDATA(UART_RDATA)
        );
        
    assign RX_Status = {OVF, FERR, PERR};
endmodule
