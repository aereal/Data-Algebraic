package Data::Algebraic::Derivation::Numeral;
use strict;
use warnings;
use parent qw(Data::Algebraic::Derivation::Common);

use Data::Algebraic::Util::Accessor;

Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'from');

sub define_values {
  my ($self) = @_;

  my @values;
  my $ordinal = $self->from // 1;
  for my $name (@{ $self->names }) {
    my $v = $self->create_value(name => $name, raw => $ordinal);
    push @values, $v;
    Data::Algebraic::Util::Accessor::define_sub($self->entity_class, $name, sub { $v });
    $ordinal++;
  }

  return \@values;
}

sub create_value {
  my ($self, %args) = @_;
  return bless \%args, $self->entity_class;
}

1;

__END__

=head1 NAME

Data::Algebraic::Derivation::Numeral

=head1 DESCRIPTION

L<Data::Algebraic::Derivation::Numeral> creates instance data that based on ordinary numbers.

=cut
