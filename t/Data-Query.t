use strict;
use warnings;
use Test::More;

use Data::Query;

{
    my $q = Data::Query->parse('name=you');
    ok $q->matches({ name => 'you' });
    ok $q->matches({ name => 'you', 'is' => 'ok' });
    ok ! $q->matches({ });
    ok ! $q->matches({ name => 'unknown' });
};

done_testing;
