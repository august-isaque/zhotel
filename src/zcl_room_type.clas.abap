class zcl_room_type definition
  public
  final
  create public .

  public section.
    class-methods:
      get_room_type_by_id
        importing iv_id         type integer
        returning value(return) type ref to zcl_room_type.
    methods:
      save
        importing
          io_room_type type ref to zcl_room_type,
      constructor
        importing
          iv_description  type string128
          iv_max_capacity type integer
          iv_id           type integer optional,
      set_description
        importing
          iv_description type string128,
      get_description
        returning
          value(return) type string128,
      set_max_capacity
        importing
          iv_max_capacity type integer,
      get_max_capacity
        returning
          value(return) type integer,
      get_next_id
        returning
          value(return) type integer,
      get_last_id
        returning
          value(return) type integer,


      set_id importing iv_id type integer,
      get_id returning value(return) type integer.


  protected section.
  private section.

    data description type string128 .
    data max_capacity type integer .
    data id type integer .
ENDCLASS.



CLASS ZCL_ROOM_TYPE IMPLEMENTATION.


  method constructor.
    me->description = iv_description.
    me->max_capacity = iv_max_capacity.
    me->id = iv_id.
  endmethod.


  method get_description.
    return = me->description.
  endmethod.


  method get_id.
    return = me->id.
  endmethod.


  method get_last_id.
    data: i type integer.

    select max( id ) from zroom_type into i.
    return = i.
  endmethod.


  method get_max_capacity.
    return = me->max_capacity.
  endmethod.


  method get_next_id.


    select max( id ) from zroom_type into @data(lv_id).
    if sy-subrc <> 0.
      return = '00001'.
    else.
      return = lv_id + 1.
    endif.


  endmethod.


  method get_room_type_by_id.
    select * from zroom_type
    where
    id = @iv_id
    into table @data(it_rtype).

    data: ls_rtype like line of it_rtype.

    read table it_rtype into ls_rtype index 1.

    if sy-subrc = 0.
      data lo_rtype type ref to zcl_room_type.
      create object lo_rtype
        exporting
          iv_description  = ls_rtype-description
          iv_max_capacity = ls_rtype-max_capacity
          iv_id           = ls_rtype-id.
      return = lo_rtype.
    endif.

  endmethod.


  method save.
    data: wa_room_type type zroom_type,
          i            type integer.

    wa_room_type-description = io_room_type->get_description( ).
    wa_room_type-max_capacity = io_room_type->get_max_capacity( ).
    wa_room_type-id = get_next_id( ).

    insert zroom_type from wa_room_type.
  endmethod.


  method set_description.
    me->description = iv_description.
  endmethod.


  method set_id.
    me->id = iv_id.
  endmethod.


  method set_max_capacity.
    me->max_capacity = iv_max_capacity.
  endmethod.
ENDCLASS.
