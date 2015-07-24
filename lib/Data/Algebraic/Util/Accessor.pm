package Data::Algebraic::Util::Accessor;
use strict;
use warnings;

sub define_ro_accessor {
  my($dest_class, $name) = @_;

  define_sub($dest_class, $name, sub { $_[0]->{$name} });
}

sub define_sub {
  my ($dest_class, $name, $value) = @_;
  my $qualified_name = join '::', $dest_class, $name;

  no strict 'refs';
  *{ $qualified_name } = $value;
}

sub define_scalar_var {
  my ($dest_class, $name, $value) = @_;
  my $qualified_name = join '::', $dest_class, $name;

  no strict 'refs';
  no warnings 'once';
  ${ $qualified_name } = $value;
}

1;
