//******************************************************************************//
//  File Name: 	Rx_Engine_Datapath.v                                            //
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

module Rx_Engine_Datapath(
    input           clk,
    input           rst,
    input           RX,
    input           EIGHT,
    input           PEN,
    input           OHEL,
    input           BTU,
    input           start,
    input           Read,
    input           DONE,
    output          RXRDY,
    output          PERR,
    output          FERR,
    output          OVF,
    output  [7:0]   UART_RDATA
    );
    
    wire    [9:0]   Q;
    wire    [9:0]   Q_Out;
    wire            SHIFT, parity_gen_sel, parity_received_sel, stop_bit_sel;
    wire            xor_first, xor_mux, xor_second;
    
    /////////////////////////////////////////////////////////
    //  Shift Register
    /////////////////////////////////////////////////////////
    assign SHIFT = BTU && (~start);
    
    Shift_Register_10Bit SR
        (
        .clk(clk),
        .rst(rst),
        .SHIFT(SHIFT),
        .SDI(RX),
        .Q(Q)
        );
    /////////////////////////////////////////////////////////
    //  Right Justify the data
    /////////////////////////////////////////////////////////
    assign UART_RDATA = Q_Out[7:0];
        
    Right_Justify RJ
        (
        .Q(Q),
        .EIGHT(EIGHT),
        .PEN(PEN),
        .Q_Out(Q_Out)
        );
        
    /////////////////////////////////////////////////////////
    //  Multiplexors on the left side
    /////////////////////////////////////////////////////////
    assign parity_gen_sel = EIGHT ? Q_Out[7] : 1'b0;
    assign parity_received_sel = EIGHT ? Q_Out[8] : Q_Out[7];
    assign stop_bit_sel =   ({EIGHT,PEN} == 2'b00) ? Q_Out[7]:
                            ({EIGHT,PEN} == 2'b01) ? Q_Out[8]:
                            ({EIGHT,PEN} == 2'b10) ? Q_Out[8]:
                                                     Q_Out[9];
    
    /////////////////////////////////////////////////////////
    //  XOR Statements
    /////////////////////////////////////////////////////////
    assign xor_first = ^({Q_Out[6:0], parity_gen_sel});
    assign xor_mux = OHEL ? ~xor_first : xor_first;
    assign xor_second = ^({xor_mux, parity_received_sel});
    
    /////////////////////////////////////////////////////////
    //  SR flops
    /////////////////////////////////////////////////////////
    SR_Flop rxrdy
        (
        .clk(clk),
        .rst(rst),
        .S(DONE),
        .R(Read),
        .Q(RXRDY)
        );
    
    SR_Flop perr
        (
        .clk(clk),
        .rst(rst),
        .S(PEN && xor_second && DONE),
        .R(Read),
        .Q(PERR)
        );
    
    SR_Flop ferr
        (
        .clk(clk),
        .rst(rst),
        .S(stop_bit_sel && DONE),
        .R(Read),
        .Q(FERR)
        );
        
    SR_Flop ovf
        (
        .clk(clk),
        .rst(rst),
        .S(DONE && RXRDY),
        .R(Read),
        .Q(OVF)
        );

endmodule
