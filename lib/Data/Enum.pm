package Data::Enum;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

sub import {
  my ($class, @args) = @_;
  my ($importer) = caller();

  my $options = {};
  while (@args) {
    my $k = $args[0];
    last unless $k =~ m/\A-/;
    shift @args;
    my $v = shift @args;
    $options->{$k} = $v;
  }
  my $names = \@args;

  $class->install($importer, $names, $options);
}

sub install {
  my ($class, $injected_class, $names, $options) = @_;

  _inject_ro_accessor($injected_class, 'name');
  _inject_ro_accessor($injected_class, 'value');

  my $from = $options->{-from} // 1;
  my $values = [];
  for my $name (@$names) {
    my $v = _define($injected_class, $name, $from);
    push @$values, $v;
    _inject_sub($injected_class, $name, sub { $v });
    my $predicate_name = sprintf 'is_%s', lc $name;
    _inject_sub($injected_class, $predicate_name, sub { $_[0]->is($v) });
    $from++;
  }

  _inject_sub($injected_class, 'is', sub {
    my ($self, $other) = @_;
    $self->value == $other->value;
  });

  _inject_var($injected_class, 'VALUES', $values);
}

sub _define {
  my ($injected_class, $name, $value) = @_;
  return bless {
    name  => $name,
    value => $value,
  }, $injected_class;
}

sub _inject_ro_accessor {
  my($dest_class, $name) = @_;

  _inject_sub($dest_class, $name, sub { $_[0]->{$name} });
}

sub _inject_sub {
  my ($dest_class, $name, $value) = @_;
  my $qualified_name = join '::', $dest_class, $name;

  no strict 'refs';
  *{ $qualified_name } = $value;
}

sub _inject_var {
  my ($dest_class, $name, $value) = @_;
  my $qualified_name = join '::', $dest_class, $name;

  no strict 'refs';
  no warnings 'once';
  ${ $qualified_name } = $value;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Enum - It's new $module

=head1 SYNOPSIS

    use Data::Enum;

=head1 DESCRIPTION

Data::Enum is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

