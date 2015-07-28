[![Build Status](https://travis-ci.org/aereal/Data-Algebraic.svg?branch=master)](https://travis-ci.org/aereal/Data-Algebraic) [![Coverage Status](https://img.shields.io/coveralls/aereal/Data-Algebraic/master.svg?style=flat)](https://coveralls.io/r/aereal/Data-Algebraic?branch=master)
# NAME

Data::Algebraic - Algebraic data for Perl

# SYNOPSIS

    package Boolean;
    use Data::Algebraic -derived => [qw( Eq )], qw( True False );

    package main;
    use Boolean;

    # subroutine named as given names returns a instance of a defined type
    ref(Boolean::True); # => Boolean

    # equality
    Boolean::True->is(Boolean::True); # => 1
    Boolean::True->is_true; # => 1
    Boolean::True->is_false; # => 0

# DESCRIPTION

[Data::Algebraic](https://metacpan.org/pod/Data::Algebraic) provides some essential Algebraic data type implementations and
additional features such as a equality.

# LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

aereal <aereal@aereal.org>
