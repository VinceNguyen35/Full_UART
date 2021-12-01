`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Tx_Engine.v                                                     //
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

module Tx_Engine(
    input           clk,
    input           rst,
    input           Write,
    input           EIGHT,
    input           PEN,
    input           OHEL,
    input   [18:0]  k,
    input   [7:0]   OUT_PORT,
    output  reg     TXRDY,
    output          TX
    );
    
    wire            DONE, doit, bit_10, bit_9, BTU, LD;
    wire    [7:0]   data;
    
    always @(posedge clk, posedge rst)
        if(rst)         TXRDY <= 1'b1;
        else if(DONE)   TXRDY <= 1'b1;
        else if(Write)  TXRDY <= 1'b0;
        else            TXRDY <= TXRDY;
    
    SR_Flop do_it
        (
        .clk(clk),
        .rst(rst),
        .S(Write),
        .R(DONE),
        .Q(doit)
        );
        
    LD_Reg out_port
        (
        .clk(clk),
        .rst(rst),
        .load(Write),
        .D(OUT_PORT),
        .Q(data)
        );
        
    Datapath_Decode DD
        (
        .EIGHT(EIGHT),
        .PEN(PEN),
        .OHEL(OHEL),
        .data(data),
        .bit_10(bit_10),
        .bit_9(bit_9)
        );
    
    D_Flop flipflop
        (
        .clk(clk),
        .rst(rst),
        .D(Write),
        .Q(LD)
        );
    
    Shift_Register_11Bit SR
        (
        .clk(clk),
        .rst(rst),
        .LD(LD),
        .SH(BTU),
        .SDI(1'b1),
        .bit_10(bit_10),
        .bit_9(bit_9),
        .bit_1(1'b0),
        .bit_0(1'b1),
        .data(data[6:0]),
        .SDO(TX)
        );
    
    Counter_BTU bit_time_up
        (
        .clk(clk),
        .rst(rst),
        .k(k),
        .doit(doit),
        .BTU(BTU)
        );
    
    Counter_Done count_done
        (
        .clk(clk),
        .rst(rst),
        .BTU(BTU),
        .doit(doit),
        .fx(4'b1011),
        .DONE(DONE)
        );
endmodule