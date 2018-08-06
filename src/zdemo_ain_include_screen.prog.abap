*&---------------------------------------------------------------------*
*&  Include  zdemo_ain_include_screen
*&---------------------------------------------------------------------*

module pbo_0100 output.
    set pf-status 'STATUS_0100' of program 'ZDEMO_AIN_CL00'.
endmodule.


module pai_0100 input.

  case sy-ucomm.
    when 'BACK' or 'UP' or 'EXIT'.
      leave to screen 0.
  endcase.

endmodule.
