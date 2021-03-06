use strict;
use warnings;

use Test::More;

BEGIN {
  require_ok 'Data::Algebraic';
}

subtest 'Numeral' => sub {
  {
    package t::Enum::Basic;
    use strict;
    use warnings;
    use Data::Algebraic qw( Left Right );
  };

  isa_ok +t::Enum::Basic::Left, 't::Enum::Basic';
  isa_ok +t::Enum::Basic::Right, 't::Enum::Basic';
  is +t::Enum::Basic::Left->name, 'Left';
  is +t::Enum::Basic::Right->name, 'Right';
  is +t::Enum::Basic::Left->raw, 1;
  is +t::Enum::Basic::Right->raw, 2;

  is_deeply +t::Enum::Basic->from(t::Enum::Basic::Left->raw), t::Enum::Basic::Left;
  is_deeply +t::Enum::Basic->from(t::Enum::Basic::Right->raw), t::Enum::Basic::Right;
  is_deeply +t::Enum::Basic->values, [
    t::Enum::Basic::Left,
    t::Enum::Basic::Right,
  ];
};

subtest 'Numeral (with offset)' => sub {
  {
    package t::Enum::WithOffset;
    use strict;
    use warnings;
    use Data::Algebraic (
      -from => 10,
      qw( Left Right )
    );
  };

  is +t::Enum::WithOffset::Left->raw, 10;
  is +t::Enum::WithOffset::Right->raw, 11;
};

subtest 'Eq' => sub {
  {
    package t::Bool;
    use strict;
    use warnings;
    use Data::Algebraic (
      -derived => [qw( Eq )],
      qw( True False )
    );
  };

  ok +t::Bool::True->is_true;
  ok !t::Bool::True->is_false;
  ok !t::Bool::False->is_true;
  ok +t::Bool::False->is_false;

  ok +t::Bool::True->is(t::Bool::True);
  ok !t::Bool::True->is(t::Bool::False);
  ok !t::Bool::False->is(t::Bool::True);
  ok +t::Bool::False->is(t::Bool::False);

  ok !t::Bool::True->is(1);
  ok !t::Bool::True->is(bless {}, 't');
};

done_testing;
