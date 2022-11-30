*&---------------------------------------------------------------------*
*& Report ZCREATE_GUEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
report zcreate_guest.


start-of-selection.

  selection-screen begin of block b1 with frame title text-001.
  parameters: p_fname  type string128,
              p_lname  type string128,
              p_bdate  type datum,
              p_msince type datum.

  selection-screen end of block b1.

  data: lo_guest TYPE REF TO zcl_guest.

  create OBJECT lo_guest
    exporting
      iv_member_since = p_msince
      iv_first_name   = p_fname
      iv_last_name    = p_lname
      iv_birth_date   = p_bdate
    .

  lo_guest->save( io_person = lo_guest ).
