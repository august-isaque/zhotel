*&---------------------------------------------------------------------*
*& Report ZDISPLAY_GUESTS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zdisplay_guests.


start-of-selection.

  parameters p_datum type datum.

  data(lt_list) = zcl_guest=>get_guest_list( ).

  data: lo_alv     type ref to cl_salv_table.

  cl_salv_table=>factory(
    importing
      r_salv_table  = lo_alv                       " Basis Class Simple ALV Tables
    changing
      t_table       = lt_list
  ).

  lo_alv->display( ).

end-of-selection.
