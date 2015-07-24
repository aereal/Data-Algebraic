package Data::Enum::Installer::Numeral;
use strict;
use warnings;

use Data::Enum::Util::Accessor;

Data::Enum::Util::Accessor::define_ro_accessor(__PACKAGE__, 'names');
Data::Enum::Util::Accessor::define_ro_accessor(__PACKAGE__, 'from');
Data::Enum::Util::Accessor::define_ro_accessor(__PACKAGE__, 'entity_class');

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

sub install {
  my ($self) = @_;

  Data::Enum::Util::Accessor::define_ro_accessor($self->entity_class, 'name');
  Data::Enum::Util::Accessor::define_ro_accessor($self->entity_class, 'value');

  my $from = $self->from // 1;
  my $values_by_name = {};
  for my $name (@{ $self->names }) {
    my $v = $self->create_value(name => $name, value => $from);
    $values_by_name->{$v->value} = $v;
    Data::Enum::Util::Accessor::define_sub($self->entity_class, $name, sub { $v });
    my $predicate_name = sprintf 'is_%s', lc $name;
    Data::Enum::Util::Accessor::define_sub($self->entity_class, $predicate_name, sub { $_[0]->is($v) });
    $from++;
  }

  Data::Enum::Util::Accessor::define_sub($self->entity_class, 'is', sub {
    my ($self, $other) = @_;
    $self->value == $other->value;
  });

  Data::Enum::Util::Accessor::define_sub($self->entity_class, 'from', sub {
    my ($class, $value) = @_;
    $values_by_name->{$value};
  });

  Data::Enum::Util::Accessor::define_scalar_var($self->entity_class, 'VALUES', [ values %$values_by_name ]);
}

sub create_value {
  my ($self, %args) = @_;
  return bless \%args, $self->entity_class;
}

1;
