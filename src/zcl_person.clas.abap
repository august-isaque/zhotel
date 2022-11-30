class zcl_person definition
  public
  create public .

  public section.

    methods constructor
      importing
        !iv_first_name type string128
        !iv_last_name  type string128
        !iv_birth_date type datum .
    methods set_first_name
      importing
        !iv_first_name type string128 .
    methods get_first_name
      returning
        value(return) type string128 .
    methods set_last_name
      importing
        !iv_last_name type string128 .
    methods get_last_name
      returning
        value(return) type string128 .
    methods set_birth_date
      importing
        !iv_birth_date type datum .
    methods get_birth_date
      returning
        value(return) type datum .
    methods save
      importing
        io_person type ref to zcl_person.
    methods get_next_id
      returning
        value(return) type integer.
    methods get_last_id
      returning
        value(return) type integer.
  protected section.
  private section.

    data first_name type string128 .
    data last_name type string128 .
    data birth_date type datum .
ENDCLASS.



CLASS ZCL_PERSON IMPLEMENTATION.


  method constructor.
    me->first_name = iv_first_name.
    me->last_name = iv_last_name.
    me->birth_date = iv_birth_date.
  endmethod.


  method get_birth_date.
    return = me->birth_date.
  endmethod.


  method get_first_name.
    return = me->first_name.
  endmethod.


  method get_last_id.
    select max( id ) from zperson into @data(i).
    return = i.
  endmethod.


  method get_last_name.
    return = me->last_name.
  endmethod.


  method get_next_id.


    select max( id ) from zperson into @data(i).
    if sy-subrc <> 0.
      return = '00001'.
    else.
      return = i + 1.
    endif.


  endmethod.


  method save.
    data: wa_person type zperson.


    wa_person-first_name = io_person->get_first_name( ).
    wa_person-last_name = io_person->get_last_name( ).
    wa_person-id = get_next_id( ).
    wa_person-birth_date = io_person->get_birth_date( ).

    insert zperson from wa_person.

  endmethod.


  method set_birth_date.
    me->birth_date = iv_birth_date.
  endmethod.


  method set_first_name.
    me->first_name = iv_first_name.
  endmethod.


  method set_last_name.
    me->last_name = iv_last_name.
  endmethod.
ENDCLASS.
