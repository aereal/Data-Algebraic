package Data::Enum;
use 5.008001;
use strict;
use warnings;

use Data::Enum::Installer::Numeral;

our $VERSION = "0.01";

sub import {
  my ($class, @args) = @_;
  my ($importer) = caller();

  my $installer = Data::Enum::Installer::Numeral->parse(@args);
  $installer->install($importer);
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

