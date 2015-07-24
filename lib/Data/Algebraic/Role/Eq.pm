package Data::Algebraic::Role::Eq;
use strict;
use warnings;

use Data::Algebraic::Util::Accessor;

sub assumes {
  my ($class, $entity_class) = @_;

  Data::Algebraic::Util::Accessor::define_sub($entity_class, 'is', sub {
    my ($self, $other) = @_;
    $self->value == $other->value;
  });

  for my $value (@{ $entity_class->values }) {
    my $predicate_name = sprintf 'is_%s', lc $value->name;
    Data::Algebraic::Util::Accessor::define_sub($entity_class, $predicate_name, sub { $_[0]->is($value) });
  }
}

1;
