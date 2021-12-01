`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Project4.v                                                      //
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

module Project4(
    input               clk,
    input               rst,
    input       [3:0]   Baud,
    input               EIGHT,
    input               PEN,
    input               OHEL,
    input               RX,

    output              TX,
    output  reg [15:0]  LED
    );

    wire    [15:0]  OUT_PORT, PORT_ID;
    wire    [7:0]   write, read, UART_DS;
    wire            INTERRUPT, INTERRUPT_ACK, READ_STROBE, WRITE_STROBE;
    wire            Reset_S, TXRDY, PED_OUT, LED_LOAD, UART_INT;

    AISO u1
        (
        .clk(clk),
        .rst(rst),
        .Reset_S(Reset_S)
        );
    
    tramelblaze_top u2
        (
        .CLK(clk), 
        .RESET(Reset_S), 
        .IN_PORT({8'b0,UART_DS}), 
        .INTERRUPT(INTERRUPT), 
                    
        .OUT_PORT(OUT_PORT), 
        .PORT_ID(PORT_ID), 
        .READ_STROBE(READ_STROBE), 
        .WRITE_STROBE(WRITE_STROBE), 
        .INTERRUPT_ACK(INTERRUPT_ACK)
        );
    
    Adrs_Decode u4
        (
        .port_ID(PORT_ID),
        .write_strobe(WRITE_STROBE),
        .read_strobe(READ_STROBE),
    
        .write(write),
        .read(read)
        );
    
    UART u5
        (
        .clk(clk),
        .rst(Reset_S),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .OHEL(OHEL),
        .RX(RX),
        .Write(write[0]),
        .Read(read[1:0]),
        .Baud(Baud),
        .OUT_PORT(OUT_PORT),
    
        .TX(TX),
        .UART_INT(UART_INT),
        .UART_DS(UART_DS)
        );
        
    PED u6
        (
        .clk(clk),
        .rst(Reset_S),
        .D(UART_INT),
        .out(PED_OUT)
        );
    
    SR_Flop u7
        (
        .clk(clk),
        .rst(Reset_S),
        .S(PED_OUT),
        .R(INTERRUPT_ACK),
        .Q(INTERRUPT)
        );
    
    assign LED_LOAD = write[2];
    
    always @(posedge clk, posedge rst)
        if(rst)
            LED <= 16'b0;
        else if(LED_LOAD)
            LED <= OUT_PORT;
        else
            LED <= LED;
endmodule