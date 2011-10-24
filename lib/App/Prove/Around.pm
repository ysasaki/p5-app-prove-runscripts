package App::Prove::Around;

use 5.008008;
use strict;
use warnings;
use parent 'App::Prove';
use Class::Method::Modifiers;
use Getopt::Long;

our $VERSION = 'y';

around 'process_args' => sub {
    my $orig = shift;
    my ( $self, @args ) = @_;
    {
        local @ARGV = @args;
        Getopt::Long::Configure(qw(no_ignore_case bundling pass_through));
        GetOptions(
            'before=s' => \$self->{before},
            'after=s'  => \$self->{after},
        );
        $orig->( $self, @ARGV );
    }
};

around 'run' => sub {
    my $orig = shift;
    my $self = shift;
    $self->_do('before');
    my $ret = $orig->($self);
    $self->_do('after');
    return $ret;
};

sub _do {
    my $self = shift;
    my $type = shift;
    if ( my $script = $self->{$type} ) {
        local $@;
        do $script;
        die $@ if $@;
    }
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

App::Prove::Around - Run scripts around a TAP harness.

=head1 SYNOPSIS

  use App::Prove::Around;

  my $app = App::Prove::Around->new;
  $app->process_args(@ARGV);
  $app->run;

=head1 DESCRIPTION

Stub documentation for App::Prove::Around, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 SEE ALSO

L<App::Prove>, L<Module::Install::TestTarget>

=head1 AUTHOR

Yoshihiro Sasaki E<lt>ysasaki at cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2011 Yoshihiro Sasaki All rights reserved.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
