package Data::Enum::Installer::Numeral;
use strict;
use warnings;

use Data::Enum::Util::Accessor;

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

sub names { return $_[0]->{names} }

sub from { return $_[0]->{from} }

sub install {
  my ($self, $implement_class) = @_;

  Data::Enum::Util::Accessor::define_ro_accessor($implement_class, 'name');
  Data::Enum::Util::Accessor::define_ro_accessor($implement_class, 'value');

  my $from = $self->from // 1;
  my $values_by_name = {};
  for my $name (@{ $self->names }) {
    my $v = _define($implement_class, $name, $from);
    $values_by_name->{$v->value} = $v;
    Data::Enum::Util::Accessor::define_sub($implement_class, $name, sub { $v });
    my $predicate_name = sprintf 'is_%s', lc $name;
    Data::Enum::Util::Accessor::define_sub($implement_class, $predicate_name, sub { $_[0]->is($v) });
    $from++;
  }

  Data::Enum::Util::Accessor::define_sub($implement_class, 'is', sub {
    my ($self, $other) = @_;
    $self->value == $other->value;
  });

  Data::Enum::Util::Accessor::define_sub($implement_class, 'from', sub {
    my ($class, $value) = @_;
    $values_by_name->{$value};
  });

  Data::Enum::Util::Accessor::define_scalar_var($implement_class, 'VALUES', [ values %$values_by_name ]);
}

sub _define {
  my ($injected_class, $name, $value) = @_;
  return bless {
    name  => $name,
    value => $value,
  }, $injected_class;
}

1;
