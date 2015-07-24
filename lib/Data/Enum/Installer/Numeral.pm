package Data::Enum::Installer::Numeral;
use strict;
use warnings;
use parent qw( Data::Enum::Installer::Common );

use Data::Enum::Util::Accessor;

Data::Enum::Util::Accessor::define_ro_accessor(__PACKAGE__, 'from');

sub define_values {
  my ($self) = @_;

  my $from = $self->from // 1;
  for my $name (@{ $self->names }) {
    my $v = $self->create_value(name => $name, value => $from);
    $self->define_value($v);
    Data::Enum::Util::Accessor::define_sub($self->entity_class, $name, sub { $v });
    my $predicate_name = sprintf 'is_%s', lc $name;
    Data::Enum::Util::Accessor::define_sub($self->entity_class, $predicate_name, sub { $_[0]->is($v) });
    $from++;
  }
}

sub create_value {
  my ($self, %args) = @_;
  return bless \%args, $self->entity_class;
}

1;
