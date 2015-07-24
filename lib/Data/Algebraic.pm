package Data::Algebraic;
use 5.008001;
use strict;
use warnings;

use Data::Algebraic::Derivation::Numeral;

our $VERSION = "0.01";

sub import {
  my ($class, @args) = @_;
  my ($importer) = caller();

  my $installer = Data::Algebraic::Derivation::Numeral->parse(
    -entity_class => $importer,
    @args
  );
  $installer->define();
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Algebraic - Algebraic data for Perl

=head1 SYNOPSIS

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

=head1 DESCRIPTION

L<Data::Algebraic> provides some essential Algebraic data type implementations and
additional features such as a equality.

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

