use strict;
use warnings;
use Test::More;
use App::Prove::RunScripts;
use t::Utils;

subtest 'empty args' => sub {
    my $app = app_with_args( [] );
    ok !$app->{before}, 'before option does not exist';
    ok !$app->{after},  'after option does not exist';
};

subtest 'with before' => sub {
    my $app = app_with_args( [qw(--before hello.pl)] );
    is $app->{before}, 'hello.pl', 'before option exists';
    ok !$app->{after}, 'after option does not exist';
};

subtest 'with after' => sub {
    my $app = app_with_args( [qw(--after hello.pl)] );
    ok !$app->{before}, 'before option does not exist';
    is $app->{after}, 'hello.pl', 'after option exists';
};

subtest 'with before and after' => sub {
    my $app = app_with_args( [qw(--before hello1.pl --after hello2.pl)] );
    is $app->{before}, 'hello1.pl', 'before option exists';
    is $app->{after},  'hello2.pl', 'after option exists';
};

done_testing;
