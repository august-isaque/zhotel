*&---------------------------------------------------------------------*
*& Report ZDISPLAY_RESERVATIONS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zdisplay_reservations.


data(lt_list) = zcl_reservation=>get_reservation_list( ).

data: lo_alv     type ref to cl_salv_table.

cl_salv_table=>factory(
  importing
    r_salv_table  = lo_alv                       " Basis Class Simple ALV Tables
  changing
    t_table       = lt_list
).

lo_alv->display( ).
