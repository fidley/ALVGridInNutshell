*&---------------------------------------------------------------------*
*& Report zdemo_ain_cl17
*&---------------------------------------------------------------------*
*& This is the demo program written for book:
*& ALV grid in nutshell by Łukasz Pęgiel
*&---------------------------------------------------------------------*
report zdemo_ain_cl17.

include zdemo_ain_include_screen.

start-of-selection.

data(grid) = new cl_gui_alv_grid(
                  i_parent = new cl_gui_custom_container( container_name = 'CC' )
                                 ).

data(fcat) = value lvc_t_fcat(
                               ( fieldname = 'SYMBOL' symbol = abap_true )
                               ( fieldname = 'NAME' )
                             ).

types: begin of t_symbol,
         symbol type char01,
         name   type string,
       end of t_symbol.
data symbols type standard table of t_symbol.
symbols = value #(
                  ( symbol = sym_space              name = 'SYM_SPACE             ' )
                  ( symbol = sym_plus_box           name = 'SYM_PLUS_BOX          ' )
                  ( symbol = sym_minus_box          name = 'SYM_MINUS_BOX         ' )
                  ( symbol = sym_plus_circle        name = 'SYM_PLUS_CIRCLE       ' )
                  ( symbol = sym_minus_circle       name = 'SYM_MINUS_CIRCLE      ' )
                  ( symbol = sym_filled_square      name = 'SYM_FILLED_SQUARE     ' )
                  ( symbol = sym_half_filled_square name = 'SYM_HALF_FILLED_SQUARE' )
                  ( symbol = sym_square            name = ' SYM_SQUARE            ' )
                  ( symbol = sym_filled_circle      name = 'SYM_FILLED_CIRCLE     ' )
                  ( symbol = sym_half_filled_circle name = 'SYM_HALF_FILLED_CIRCLE' )
                  ( symbol = sym_circle             name = 'SYM_CIRCLE            ' )
                  ( symbol = sym_filled_diamond     name = 'SYM_FILLED_DIAMOND    ' )
                  ( symbol = sym_diamond            name = 'SYM_DIAMOND           ' )
                  ( symbol = sym_bold_x             name = 'SYM_BOLD_X            ' )
                  ( symbol = sym_note               name = 'SYM_NOTE              ' )
                  ( symbol = sym_document           name = 'SYM_DOCUMENT          ' )
                  ( symbol = sym_checked_document   name = 'SYM_CHECKED_DOCUMENT  ' )
                  ( symbol = sym_documents          name = 'SYM_DOCUMENTS         ' )
                  ( symbol = sym_folder             name = 'SYM_FOLDER            ' )
                  ( symbol = sym_plus_folder        name = 'SYM_PLUS_FOLDER       ' )
                  ( symbol = sym_minus_folder       name = 'SYM_MINUS_FOLDER      ' )
                  ( symbol = sym_open_folder        name = 'SYM_OPEN_FOLDER       ' )
                  ( symbol = sym_bold_minus         name = 'SYM_BOLD_MINUS        ' )
                  ( symbol = sym_bold_plus          name = 'SYM_BOLD_PLUS         ' )
                  ( symbol = sym_checkbox           name = 'SYM_CHECKBOX          ' )
                  ( symbol = sym_radiobutton        name = 'SYM_RADIOBUTTON       ' )
                  ( symbol = sym_left_triangle      name = 'SYM_LEFT_TRIANGLE     ' )
                  ( symbol = sym_right_triangle     name = 'SYM_RIGHT_TRIANGLE    ' )
                  ( symbol = sym_up_triangle        name = 'SYM_UP_TRIANGLE       ' )
                  ( symbol = sym_down_triangle      name = 'SYM_DOWN_TRIANGLE     ' )
                  ( symbol = sym_left_hand          name = 'SYM_LEFT_HAND         ' )
                  ( symbol = sym_left_arrow         name = 'SYM_LEFT_ARROW        ' )
                  ( symbol = sym_right_arrow        name = 'SYM_RIGHT_ARROW       ' )
                  ( symbol = sym_up_arrow           name = 'SYM_UP_ARROW          ' )
                  ( symbol = sym_down_arrow         name = 'SYM_DOWN_ARROW        ' )
                  ( symbol = sym_check_mark         name = 'SYM_CHECK_MARK        ' )
                  ( symbol = sym_pencil             name = 'SYM_PENCIL            ' )
                  ( symbol = sym_glasses            name = 'SYM_GLASSES           ' )
                  ( symbol = sym_locked             name = 'SYM_LOCKED            ' )
                  ( symbol = sym_unlocked           name = 'SYM_UNLOCKED          ' )
                  ( symbol = sym_phone              name = 'SYM_PHONE             ' )
                  ( symbol = sym_printer            name = 'SYM_PRINTER           ' )
                  ( symbol = sym_fax                name = 'SYM_FAX               ' )
                  ( symbol = sym_asterisk           name = 'SYM_ASTERISK          ' )
                  ( symbol = sym_right_hand         name = 'SYM_RIGHT_HAND        ' )
                  ( symbol = sym_sorted_up          name = 'SYM_SORTED_UP         ' )
                  ( symbol = sym_sorted_down        name = 'SYM_SORTED_DOWN       ' )
                  ( symbol = sym_cumulated          name = 'SYM_CUMULATED         ' )
                  ( symbol = sym_delete             name = 'SYM_DELETE            ' )
                  ( symbol = sym_executable         name = 'SYM_EXECUTABLE        ' )
                  ( symbol = sym_workflow_item      name = 'SYM_WORKFLOW_ITEM     ' )
                  ( symbol = sym_caution            name = 'SYM_CAUTION           ' )
                  ( symbol = sym_flash              name = 'SYM_FLASH             ' )
                  ( symbol = sym_large_square       name = 'SYM_LARGE_SQUARE      ' )
                  ( symbol = sym_ellipsis           name = 'SYM_ELLIPSIS          ' ) ).


grid->set_table_for_first_display(
  changing
    it_fieldcatalog               = fcat
    it_outtab                     = symbols
  exceptions
    invalid_parameter_combination = 1
    program_error                 = 2
    too_many_lines                = 3
    others                        = 4
).
if sy-subrc eq 0.
  call screen 0100.
endif.
