*&---------------------------------------------------------------------*
*& Include          ZCREATE_RESERVATION_SEL
*&---------------------------------------------------------------------*

*Selection Screen: Create Guest*
selection-screen begin of block cr_guest with frame title text-001.
parameters: p_fname  type string128 OBLIGATORY,
            p_lname  type string128 OBLIGATORY,
            p_bdate  type datum OBLIGATORY,
            p_msince type datum OBLIGATORY.
selection-screen end of block cr_guest.

*Selection Screen: Create Dates*
selection-screen begin of block cr_rev with frame title text-002.
parameters: p_d_in type datum OBLIGATORY,
            p_d_ou type datum OBLIGATORY.
selection-screen end of block cr_rev.

*Selection Screen: Create Room*
selection-screen begin of block sl_rom with frame title text-003.
parameters: p_room type i matchcode object zsh_room OBLIGATORY.
selection-screen end of block sl_rom.
