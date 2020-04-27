*&---------------------------------------------------------------------*
*& Report
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
REPORT zdemo_ain_cl44.

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
    METHODS set_handlers.
    METHODS show_grid.
    METHODS hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        !e_row_id
        !e_column_id
        !es_row_no.
ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.
  METHOD set_handlers.
    SET HANDLER hotspot_click FOR grid.
  ENDMETHOD.

  METHOD create_grid.
    grid = NEW cl_gui_alv_grid(
                 i_parent = NEW cl_gui_custom_container( container_name = 'CC' )
                                ).
  ENDMETHOD.

  METHOD display.
    create_grid( ).
    prepare_fcat( ).
    set_handlers( ).
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

  METHOD hotspot_click.

    ASSIGN flights[ e_row_id-index ] TO FIELD-SYMBOL(<flight>).
    IF sy-subrc EQ 0.
     ASSIGN COMPONENT e_column_id-fieldname of STRUCTURE <flight> to FIELD-SYMBOL(<field_value>).
     check sy-subrc eq 0.
      DATA(popup) = cl_demo_output=>new( mode = 'TEXT' ).
      popup->write_text(  |You have clicked on column { e_column_id-fieldname } of row number { e_row_id-index }|  ).
      popup->write_text(  |Its value is { <field_value> }| ).
      popup->display(  ).
    ENDIF.

  ENDMETHOD.

  METHOD prepare_fcat.
    fcat = VALUE lvc_t_fcat(
                                   ( fieldname = 'CARRID' ref_table = 'SPFLI' )
                                   ( fieldname = 'CONNID' ref_table = 'SPFLI' )
                                   ( fieldname = 'COUNTRYFR' ref_table = 'SPFLI' )
                                   ( fieldname = 'CITYFROM'  ref_table = 'SPFLI' hotspot = abap_true  )
                                   ( fieldname = 'AIRPFROM'  ref_table = 'SPFLI' )
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
