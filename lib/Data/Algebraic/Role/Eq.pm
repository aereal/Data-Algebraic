package Data::Algebraic::Role::Eq;
use strict;
use warnings;

use Scalar::Util qw( blessed );

use Data::Algebraic::Util::Accessor;

sub assumes {
  my ($class, $entity_class) = @_;

  Data::Algebraic::Util::Accessor::define_sub($entity_class, 'is', sub {
    my ($self, $other) = @_;
    blessed($other) && $other->isa(ref($self)) && $self->raw == $other->raw;
  });

  for my $value (@{ $entity_class->values }) {
    my $predicate_name = sprintf 'is_%s', lc $value->name;
    Data::Algebraic::Util::Accessor::define_sub($entity_class, $predicate_name, sub { $_[0]->is($value) });
  }
}

1;
