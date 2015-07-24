package Data::Algebraic::Derivation::Common;
use strict;
use warnings;

use Data::Algebraic::Util::Accessor;

Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'names');
Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'entity_class');

sub parse {
  my ($class, @args) = @_;

  my $options = {};
  while (@args) {
    my $k = $args[0];
    last unless $k =~ s/\A-//;
    shift @args;
    my $v = shift @args;
    $options->{$k} = $v;
  }
  my $names = \@args;

  my $self = bless {
    names => $names,
    %$options,
  }, $class;
  return $self;
}

sub define {
  my ($self) = @_;

  Data::Algebraic::Util::Accessor::define_ro_accessor($self->entity_class, 'name');
  Data::Algebraic::Util::Accessor::define_ro_accessor($self->entity_class, 'value');

  $self->define_values();
  my $values_by_raw_value = $self->{defined_values_by_raw_value};
  my $values = [ values %$values_by_raw_value ];

  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, 'is', sub {
    my ($self, $other) = @_;
    $self->value == $other->value;
  });

  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, 'from', sub {
    my ($class, $value) = @_;
    $values_by_raw_value->{$value};
  });

  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, 'values', sub { $values });
}

sub define_value {
  my ($self, $value) = @_;
  ($self->{defined_values_by_raw_value} //= {})->{$value->value} = $value;

  my $predicate_name = sprintf 'is_%s', lc $value->name;
  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, $predicate_name, sub { $_[0]->is($value) });
}

1;
