use strict;
use warnings;

use Test::More;

BEGIN {
  require_ok 'Data::Enum';
}

subtest 'Numeral' => sub {
  package t::Enum::Basic {
    use strict;
    use warnings;
    use Data::Enum qw( Left Right );
  };

  isa_ok +t::Enum::Basic::Left, 't::Enum::Basic';
  isa_ok +t::Enum::Basic::Right, 't::Enum::Basic';
  is +t::Enum::Basic::Left->name, 'Left';
  is +t::Enum::Basic::Right->name, 'Right';
  is +t::Enum::Basic::Left->value, 1;
  is +t::Enum::Basic::Right->value, 2;
  ok +t::Enum::Basic::Left->is(t::Enum::Basic::Left);
  ok +t::Enum::Basic::Right->is(t::Enum::Basic::Right);
  ok +t::Enum::Basic::Left->is_left;
  ok !t::Enum::Basic::Left->is_right;
  ok !t::Enum::Basic::Right->is_left;
  ok +t::Enum::Basic::Right->is_right;
};

done_testing;
