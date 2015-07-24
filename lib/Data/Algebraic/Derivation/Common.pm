package Data::Algebraic::Derivation::Common;
use strict;
use warnings;
use Module::Load ();

use Data::Algebraic::Util::Accessor;

Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'names');
Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'entity_class');
Data::Algebraic::Util::Accessor::define_ro_accessor(__PACKAGE__, 'derived');

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
  Data::Algebraic::Util::Accessor::define_ro_accessor($self->entity_class, 'raw');

  my $values = $self->define_values();
  my $values_by_raw = { map { ($_->raw, $_) } @$values };

  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, 'from', sub {
    my ($class, $value) = @_;
    $values_by_raw->{$value};
  });

  Data::Algebraic::Util::Accessor::define_sub($self->entity_class, 'values', sub { $values });

  for my $role (@{ $self->derived // [] }) {
    my $role_class = "Data::Algebraic::Role::$role";
    Module::Load::load($role_class);
    $role_class->assumes($self->entity_class);
  }
}

1;
