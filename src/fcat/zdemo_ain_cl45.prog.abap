*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl45.

INCLUDE zdemo_ain_include_screen.

CLASS lcl_alv DEFINITION CREATE PUBLIC FINAL.
  PUBLIC SECTION.
    DATA: flights TYPE STANDARD TABLE OF spfli.

    METHODS display.
    METHODS select_flights.
  PROTECTED SECTION.
    DATA: grid TYPE REF TO cl_gui_alv_grid,
          fcat TYPE lvc_t_fcat.
    METHODS prepare_fcat.
    METHODS create_grid.
    METHODS show_grid.

ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.


  METHOD create_grid.
    grid = NEW cl_gui_alv_grid(
                 i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                ).
  ENDMETHOD.

  METHOD display.
    create_grid( ).
    prepare_fcat( ).
    show_grid( ).
  ENDMETHOD.

  METHOD show_grid.
    grid->set_table_for_first_display(
    EXPORTING
        is_layout = VALUE #( col_opt = abap_true )
    CHANGING
      it_fieldcatalog               = fcat
      it_outtab                     = flights
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
  ).
    IF sy-subrc EQ 0.
      CALL SCREEN 0100.
    ENDIF.
  ENDMETHOD.


  METHOD prepare_fcat.
    fcat = VALUE lvc_t_fcat(
                                   ( fieldname = 'CARRID' ref_table = 'SPFLI' )
                                   ( fieldname = 'CONNID' ref_table = 'SPFLI' )
                                   ( fieldname = 'COUNTRYFR'  ref_table = 'SPFLI' dfieldname = 'CONNID'  )
                                   ( fieldname = 'CITYFROM'  ref_table = 'SPFLI' dfieldname = 'CONNID' )
                                   ( fieldname = 'AIRPFROM'  ref_table = 'SPFLI'  )
                                   ( fieldname = 'COUNTRYTO' ref_table = 'SPFLI' )
                                   ( fieldname = 'CITYTO'   ref_table = 'SPFLI'  )
                                   ( fieldname = 'FLTIME' ref_table = 'SPFLI' )
                                   ( fieldname = 'DEPTIME' ref_table = 'SPFLI' )
                                   ( fieldname = 'FLTYPE' ref_table = 'SPFLI' )
                                 ).

  ENDMETHOD.

  METHOD select_flights.
    SELECT * UP TO 50 ROWS FROM spfli INTO CORRESPONDING FIELDS OF TABLE @flights.
  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  DATA(alv) = NEW lcl_alv( ).
  alv->select_flights( ).
  alv->display( ).
