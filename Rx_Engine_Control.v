`timescale 1ns / 1ps

//******************************************************************************//
//  File Name: 	Rx_Engine_Control.v                                             //
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

module Rx_Engine_Control(
    input           clk,
    input           rst,
    input           RX,
    input           EIGHT,
    input           PEN,
    input   [18:0]  k,
    output          BTU,
    output  wire    DONE,
    output  reg     start
    );
    
    wire    [18:0]  half_k, k_mux;
    wire    [7:0]   data;
    reg     [3:0]   fx;
    reg     [1:0]   state, nstate;
    reg             nstart, doit, ndoit;
    
    /////////////////////////////////////////////////////////
    //  Synchronous Block for State Machine
    /////////////////////////////////////////////////////////
    always @(posedge clk, posedge rst)
        if(rst)
            {state, start, doit} <= 4'b0;
        else
            {state, start, doit} <= {nstate, nstart, ndoit};
    
    /////////////////////////////////////////////////////////
    //  Combinational Block for State Machine
    /////////////////////////////////////////////////////////
    always @(*) begin
        nstate = state;
        nstart = start;
        ndoit = doit;
        case(state)
            2'b00: {nstate, nstart, ndoit} = RX     ? 4'b0000 :         4'b0111;
            2'b01: {nstate, nstart, ndoit} = RX     ? 4'b0000 : BTU ?   4'b1001 : 4'b0111;
            2'b10: {nstate, nstart, ndoit} = DONE   ? 4'b0000 :         4'b1001;
            2'b11: {nstate, nstart, ndoit} = 4'b0000;
            default: {nstate, nstart, ndoit} = 4'b0000;
        endcase
    end
    
    /////////////////////////////////////////////////////////
    //  Baud decoder for Rx_Engine
    /////////////////////////////////////////////////////////
    assign half_k = k >> 1;
    assign k_mux = start ? half_k : k;
    
    Counter_BTU bit_time_up
        (
        .clk(clk),
        .rst(rst),
        .k(k_mux),
        .doit(doit),
        .BTU(BTU)
        );
    
    Counter_Done count_done
        (
        .clk(clk),
        .rst(rst),
        .BTU(BTU),
        .doit(doit),
        .fx(fx),
        .DONE(DONE)
        );
        
    /////////////////////////////////////////////////////////
    //  Function block for bit counter
    /////////////////////////////////////////////////////////    
    always @(*)
        case({EIGHT,PEN})
            2'b00: fx = 4'b1001;
            2'b01: fx = 4'b1010;
            2'b10: fx = 4'b1010;
            2'b11: fx = 4'b1011;
            default: fx = 4'b1001;
        endcase
endmodule