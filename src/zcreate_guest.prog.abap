*&---------------------------------------------------------------------*
*& Report ZCREATE_GUEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_guest.


start-of-selection.

  selection-screen begin of block b1 with frame title text-001.
  parameters: p_fname  type string128 obligatory,
              p_lname  type string128 obligatory,
              p_bdate  type datum obligatory,
              p_msince type datum obligatory.

  selection-screen end of block b1.

at selection-screen output.
  perform clean_screen.

at selection-screen.
  perform create_guest.


form create_guest.
  data: lo_guest type ref to zcl_guest.
  lo_guest = new #(
      iv_member_since = p_msince
      iv_first_name   = p_fname
      iv_last_name    = p_lname
      iv_birth_date   = p_bdate
  ).
  lo_guest->save( lo_guest ).
  message text-002 type 'S'  .
endform.


form clean_screen.
  clear p_fname .
  clear p_lname .
  clear p_bdate .
  clear p_msince.
  modify screen.
endform.
