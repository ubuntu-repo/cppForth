: _sink_ 0 0 0 0 ;

: i32>w ' lit.i32 >w >w ;

: do immediate
    w.p 1 + ; 

: while immediate
    i32>w
    ' ?branch >w ;

: ( immediate
    do
        stream.getch dup
        0 =/=
        swap
        41 =/=
        and
    while ;

: \ immediate
    do
        stream.getch dup
        0 =/=
        swap
        10 =/=
        and
    while ; 

: if immediate ( cond -- )
    w.p 7 + i32>w   \ then addr
    ' ?branch >w
    w.p 2 +
    0 i32>w         \ else addr
    ' branch >w ; 

: then immediate
    w.p 1 + swap !w ;
    
: else immediate
    w.p 4 + swap !w \ set the else addr in IF after the coming branch
    w.p 2 +
    0 i32>w
    ' branch >w ;

: .readString
    cd.p 1 + i32>w
    do
        stream.getch dup dup dup
        0 =/=
        swap
        34 =/=
        and
        dup
        if
            dup 10 .c swap .c 10 .c
            >cd
        then
    while
    0 >cd ; \ null terminate

: " immediate
    .readString ;

: .cd
    do
        dup
        @cd
        dup .c
        swap
        1 +
        swap
    while ;

: ." immediate
    .readString
    ' .cd >w ;

        
: *2 2 * ;

: /2 2 / ;

: +1 1 + ;

: -1 1 - ;

: testifelse 0 == if 123 . then 456 . ;

: testifthenelse 0 == if 123 . else 456 . then 789 . ;

: dec100
    100
    do
        dup
        .
        1 -
        dup
        0 =/=
    while
    drop ;
