*&---------------------------------------------------------------------*
*& Report ZCREATE_RESERVATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_reservation.


selection-screen begin of block b1 with frame title text-001.
parameters: p_d_in  type datum,
            p_d_ou  type datum,
            p_g_id  type integer matchcode object zguest_id.
selection-screen end of block b1.

data: lo_reservation    type ref to zcl_reservation,
      lo_reserved_room  type ref to zcl_reserved_room,
      lo_occ_room       type ref to zcl_occupied_room,
      lo_hosted_at      type ref to zcl_hosted_at,
      lo_guest          type ref to zcl_guest.





call method zcl_guest=>get_guest_by_id
  exporting
    iv_id  = p_g_id
  receiving
    return = lo_guest.




create object lo_reservation
  exporting
    iv_date_in  = p_d_in
    iv_date_out = p_d_ou
    iv_made_by  = sy-uname
    iv_guest_id = lo_guest.

lo_reservation->save( lo_reservation ).
