package Data::Algebraic;
use 5.008001;
use strict;
use warnings;

use Data::Algebraic::Installer::Numeral;

our $VERSION = "0.01";

sub import {
  my ($class, @args) = @_;
  my ($importer) = caller();

  my $installer = Data::Algebraic::Installer::Numeral->parse(
    -entity_class => $importer,
    @args
  );
  $installer->install($importer);
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Algebraic - It's new $module

=head1 SYNOPSIS

    use Data::Algebraic;

=head1 DESCRIPTION

Data::Algebraic is ...

=head1 LICENSE

Copyright (C) aereal.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

aereal E<lt>aereal@aereal.orgE<gt>

=cut

