package Data::Algebraic::Installer::Numeral;
use strict;
use warnings;
use parent qw(Data::Algebraic::Installer::Common);

use Data::Algebraic::Util::Accessor;

Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'from');

sub define_values {
  my ($self) = @_;

  my $ordinal = $self->from // 1;
  for my $name (@{ $self->names }) {
    my $v = $self->create_value(name => $name, value => $ordinal);
    $self->define_value($v);
    Data::Algebraic::Util::Accessor::define_sub($self->entity_class, $name, sub { $v });
    $ordinal++;
  }
}

sub create_value {
  my ($self, %args) = @_;
  return bless \%args, $self->entity_class;
}

1;
