class zcl_reservation definition
  public
  final
  create public .
  public section.
    types: begin of ty_reservation,
             id        type zguest-id,
             f_name    type zperson-first_name,
             l_name    type zperson-last_name,
             check_in  type zreservation-date_in,
             check_out type zreservation-date_out,
             r_number  type zroom-room_number,
           end of ty_reservation.

    types: tt_reservation type table of ty_reservation with default key.

    class-methods:
      check_date importing iv_checkin type datum iv_checkout type datum
             returning value(return) type boolean,
      get_reservation_list returning value(return) type tt_reservation.

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
      save importing io_reservation type ref to zcl_reservation,
      set_id importing iv_id type i,
      get_id returning value(return) type i,
      get_last_id returning value(return) type i.


  protected section.

  private section.

    data date_in type datum .
    data date_out type datum .
    data made_by type syuname .
    data guest_id type ref to zcl_guest.
    data id type i.
ENDCLASS.



CLASS ZCL_RESERVATION IMPLEMENTATION.


  method check_date.
    if iv_checkin gt iv_checkout.
      return = abap_false.
    else.
      return = abap_true.
    endif.
  endmethod.


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


  method get_id.
    return = me->id.
  endmethod.


  method get_last_id.
    select max( id ) from zreservation into @data(i).
    return = i.
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


  method get_reservation_list.
    data: ls_reservation type line of  tt_reservation,
          lt_reservation type table of ty_reservation.

    select
      zguest~id,
      zperson~first_name,
      zperson~last_name,
      zreservation~date_in,
      zreservation~date_out,
      zroom~room_number
    from zoccupied_room
    inner join zroom
      on zoccupied_room~room_id = zroom~id
    inner join zreservation
      on zoccupied_room~reservation_id = zreservation~id
    inner join zguest
      on zreservation~guest_id = zguest~id
    inner join zperson
      on zguest~id = zperson~id
    into
     (@ls_reservation-id,
      @ls_reservation-f_name,
      @ls_reservation-l_name,
      @ls_reservation-check_in,
      @ls_reservation-check_out,
      @ls_reservation-r_number
      ).
      append ls_reservation to lt_reservation.
    endselect.

    RETURN = lt_reservation.
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


  method set_id.
    me->id = iv_id.
  endmethod.


  method set_made_by.
    me->made_by = iv_made_by.
  endmethod.
ENDCLASS.
