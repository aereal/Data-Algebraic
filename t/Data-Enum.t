use strict;
use warnings;

use Test::More;

BEGIN {
  require_ok 'Data::Enum';
}

subtest 'Numeral' => sub {
  package t::Enum_1 {
    use strict;
    use warnings;
    use Data::Enum qw( Left Right );
  };

  isa_ok +t::Enum_1::Left, 't::Enum_1';
  isa_ok +t::Enum_1::Right, 't::Enum_1';
  is +t::Enum_1::Left->name, 'Left';
  is +t::Enum_1::Right->name, 'Right';
  is +t::Enum_1::Left->value, 1;
  is +t::Enum_1::Right->value, 2;
  ok +t::Enum_1::Left->is(t::Enum_1::Left);
  ok +t::Enum_1::Right->is(t::Enum_1::Right);
  ok +t::Enum_1::Left->is_left;
  ok !t::Enum_1::Left->is_right;
  ok !t::Enum_1::Right->is_left;
  ok +t::Enum_1::Right->is_right;
};

done_testing;
