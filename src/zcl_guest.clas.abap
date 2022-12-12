class zcl_guest definition inheriting from zcl_person

  public
  final
  create public .

  public section.
    types: begin of ty_guests,
             id      type zguest-id,
             m_since type zguest-member_since,
             f_name  type zperson-first_name,
             l_name  type zperson-last_name,
             d_date  type zperson-birth_date,
           end of ty_guests.

    types: tt_guests type table of ty_guests with key id.

    class-methods:
      get_guest_by_id
        importing
          iv_id
            type integer
        returning
          value(return)
            type ref to zcl_guest,
      get_guest_list
        returning
          value(return)
            type tt_guests.


    methods:
      save redefinition,

      constructor
        importing
          iv_member_since type datum
          iv_first_name   type string128
          iv_last_name    type string128
          iv_birth_date   type datum
          iv_id           type integer optional,
      set_member_since
        importing
          iv_member_since type datum,
      get_member_since
        returning
          value(return) type datum,
      set_id
        importing
          iv_id type integer,
      get_id
        returning
          value(return) type integer.



  protected section.
  private section.
    data id type integer.
    data member_since type datum.
ENDCLASS.



CLASS ZCL_GUEST IMPLEMENTATION.


  method constructor.
    super->constructor(
      exporting
        iv_first_name = iv_first_name
        iv_last_name  = iv_last_name
        iv_birth_date = iv_birth_date
    ).
    me->member_since = iv_member_since.
    me->id = iv_id.
  endmethod.


  method get_guest_by_id.

    select zguest~id, zguest~member_since, zperson~first_name, zperson~last_name, zperson~birth_date
    from zguest
    inner join zperson
      on zguest~id = zperson~id
    into table @data(lt_guest)
    where zguest~id = @iv_id.

    data: ls_guest like line of lt_guest.

    read table lt_guest into ls_guest index 1.

    if sy-subrc = 0.
      data lo_guest type ref to zcl_guest.
      create object lo_guest
        exporting
          iv_member_since = ls_guest-member_since
          iv_first_name   = ls_guest-first_name
          iv_last_name    = ls_guest-last_name
          iv_birth_date   = ls_guest-birth_date
          iv_id           = ls_guest-id.
      return = lo_guest.
    endif.

  endmethod.


  method get_guest_list.

    data: ls_guests type line of  tt_guests,
          lt_guests type table of ty_guests.

    select zguest~id, zguest~member_since, zperson~first_name, zperson~last_name, zperson~birth_date
      from zguest
      inner join zperson
        on zguest~id = zperson~id
      into (@ls_guests-id,
            @ls_guests-m_since,
            @ls_guests-f_name,
            @ls_guests-l_name,
            @ls_guests-d_date).
      append ls_guests to lt_guests .
    endselect.

    return = lt_guests.

  endmethod.


  method get_id.
    return = me->id.
  endmethod.


  method get_member_since.
    return = me->member_since.
  endmethod.


  method save.
    super->save( io_person = me ).
    data: wa_guest type zguest.

    wa_guest-id = get_last_id( ).
    wa_guest-member_since = me->get_member_since( ).

    insert zguest from wa_guest.

  endmethod.


  method set_id.
    me->id = iv_id.
  endmethod.


  method set_member_since.
    me->member_since = iv_member_since.
  endmethod.
ENDCLASS.
