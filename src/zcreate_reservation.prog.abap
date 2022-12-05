*&---------------------------------------------------------------------*
*& Report ZCREATE_RESERVATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_reservation.


INCLUDE ZCREATE_RESERVATION_TOP.
INCLUDE ZCREATE_RESERVATION_SEL.


initialization.

at selection-screen output.
  perform f_clean_fields.

at selection-screen.
  perform f_create_guest.
  perform f_create_reservation.
  perform f_get_room.
  perform f_occupy_room.


form f_create_guest.
  go_guest = new #(
      iv_member_since = p_msince
      iv_first_name   = p_fname
      iv_last_name    = p_lname
      iv_birth_date   = p_bdate
  ).
  go_guest->save(  go_guest ).
  go_guest->set_id( go_guest->get_last_id( ) ).
endform.

form f_create_reservation.
  data(check_date) = zcl_reservation=>check_date( iv_checkin  = p_d_in
                                                  iv_checkout = p_d_ou ).

  if check_date eq abap_true.
    go_reservation = new #(
          iv_date_in  = p_d_in
          iv_date_out = p_d_ou
          iv_made_by  = sy-uname
          iv_guest_id = go_guest
      ).
    go_reservation->save( go_reservation ).
    go_reservation->set_id( go_reservation->get_last_id( )  ).
  else.
    message e208(00) with text-006 .
  endif.
endform.

form f_get_room.
  go_room = zcl_room=>get_room_by_id( p_room ).

  if go_room is initial.
    message e208(00) with text-004 .
  endif.
  if go_room->get_status( ) ne text-007.
    message e208(00) with text-008 .
  endif.

endform.

form f_occupy_room.
  go_occ_room = new #(
      iv_check_in       = go_reservation->get_date_in( )
      iv_check_out      = go_reservation->get_date_out( )
      iv_room_id        = go_room
      iv_reservation_id = go_reservation
  ).

  go_occ_room->save( go_occ_room  ).
  go_occ_room->set_id( go_occ_room->get_last_id( ) ).

  go_hosted_at = new #(
      iv_guest_id         = go_guest
      iv_occupied_room_id = go_occ_room
  ).
  go_hosted_at->save( go_hosted_at ).
  go_room->set_status( text-009 ).
  go_room->update_room( go_room ).
  message text-005 type 'S'  .
endform.

form f_clean_fields.
  clear p_fname.
  clear p_lname.
  clear p_bdate.
  clear p_msince.
  clear p_d_in.
  clear p_d_ou.
  clear p_room.
  modify screen.

endform.
