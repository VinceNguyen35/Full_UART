`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	UART.v                                                          //
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

module UART(
    input               clk,
    input               rst,
    input               EIGHT,
    input               PEN,
    input               OHEL,
    input               RX,
    input               Write,
    input   [1:0]       Read,
    input   [3:0]       Baud,
    input   [15:0]      OUT_PORT,
    
    output              TX,
    output              UART_INT,
    output  reg [7:0]   UART_DS
    );
    
    wire            TXRDY, RXRDY, TXRDY_PED, RXRDY_PED;
    wire    [2:0]   RX_Status;
    wire    [7:0]   UART_Status, UART_RDATA;
    wire    [18:0]  k;
    
    /////////////////////////////////////////////////////////
    //  Instantiate core UART blocks
    /////////////////////////////////////////////////////////
    Baud_Decode baud
        (
        .BaudVal(Baud),
        .k(k)
        );
    
    Tx_Engine transmit
        (
        .clk(clk),
        .rst(rst),
        .Write(Write),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .OHEL(OHEL),
        .k(k),
        .OUT_PORT(OUT_PORT[7:0]),
        .TXRDY(TXRDY),
        .TX(TX)
        );
        
    Rx_Engine receive
        (
        .clk(clk),
        .rst(rst),
        .RX(RX),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .OHEL(OHEL),
        .Read(Read[0]),
        .k(k),
        .UART_RDATA(UART_RDATA),
        .RX_Status(RX_Status),
        .RXRDY(RXRDY)
        );
        
    /////////////////////////////////////////////////////////
    //  Setup status flags
    /////////////////////////////////////////////////////////
    assign UART_Status = {3'b0, RX_Status, TXRDY, RXRDY};
    
    /////////////////////////////////////////////////////////
    //  UART data select
    /////////////////////////////////////////////////////////
    always @(*)
        if(Read[1] == 1'b1)         UART_DS = UART_Status;
        else if(Read[0] == 1'b1)    UART_DS = UART_RDATA;
        else                        UART_DS = 8'b0;
    
    /////////////////////////////////////////////////////////
    //  PEDs and UART interrupt
    /////////////////////////////////////////////////////////
    PED tx_ped
        (
        .clk(clk),
        .rst(rst),
        .D(TXRDY),
        .out(TXRDY_PED)
        );
        
    PED rx_ped
        (
        .clk(clk),
        .rst(rst),
        .D(RXRDY),
        .out(RXRDY_PED)
        );
        
    assign UART_INT = (TXRDY_PED || RXRDY_PED);
    
endmodule
