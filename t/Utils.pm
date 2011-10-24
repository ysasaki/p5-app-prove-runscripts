package t::Utils;
use strict;
use warnings;
use parent 'Exporter';
use App::Prove::Around;

our @EXPORT = qw/app_with_args/;

sub app_with_args {
    my $args = shift;
    my $app  = App::Prove::Around->new;
    $app->process_args(@$args);
    return $app;
}

1;
