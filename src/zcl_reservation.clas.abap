class zcl_reservation definition
  public
  final
  create public .

  public section.

    methods:
      constructor importing iv_date_in  type datum
                            iv_date_out type datum
                            iv_made_by  type syuname
                            iv_guest_id type ref to zcl_guest,
      set_date_in importing iv_date_in type datum,
      get_date_in returning value(return) type datum,
      set_date_out importing iv_date_out type datum,
      get_date_out returning value(return) type datum,
      set_made_by importing iv_made_by type syuname,
      get_made_by returning value(return) type syuname,
      set_guest_id importing iv_guest_id type ref to zcl_guest,
      get_guest_id returning value(return) type ref to zcl_guest,
      get_next_id returning value(return) type integer,
      save importing io_reservation type ref to zcl_reservation.







  protected section.
  private section.

    data date_in type datum .
    data date_out type datum .
    data made_by type syuname .
    data guest_id type ref to zcl_guest.
ENDCLASS.



CLASS ZCL_RESERVATION IMPLEMENTATION.


  method constructor.
    me->date_in   = iv_date_in.
    me->date_out  = iv_date_out.
    me->made_by   = iv_made_by.
    me->guest_id  = iv_guest_id.

  endmethod.


  method get_date_in.
    return = me->date_in.
  endmethod.


  method get_date_out.
    return = me->date_out.
  endmethod.


  method get_guest_id.
    return = me->guest_id.
  endmethod.


  method get_made_by.
    return = me->made_by.
  endmethod.


  method get_next_id.

    select max( id ) from zreservation into @data(i).
    if sy-subrc <> 0.
      return = '00001'.
    else.
      return = i + 1.
    endif.


  endmethod.


  method save.

    data: wa_reservation type zreservation.

    wa_reservation-date_in = io_reservation->get_date_in( ).
    wa_reservation-date_out = io_reservation->get_date_out( ).
    wa_reservation-id = get_next_id( ).
    wa_reservation-made_by = io_reservation->get_made_by( ).
    wa_reservation-guest_id = io_reservation->get_guest_id( )->get_id( ).

    insert zreservation from wa_reservation.

  endmethod.


  method set_date_in.
    me->date_in = iv_date_in.
  endmethod.


  method set_date_out.
    me->date_out = iv_date_out.
  endmethod.


  method set_guest_id.
    me->guest_id = iv_guest_id.
  endmethod.


  method set_made_by.
    me->made_by = iv_made_by.
  endmethod.
ENDCLASS.
