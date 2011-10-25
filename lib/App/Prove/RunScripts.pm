package App::Prove::RunScripts;

use 5.008008;
use strict;
use warnings;
use parent 'App::Prove';
use Class::Method::Modifiers qw(around install_modifier);
use Getopt::Long;
use Carp ();

our $VERSION = '0.03';

around 'process_args' => sub {
    my $orig = shift;
    my ( $self, @args ) = @_;

    $self->{before} = [];
    $self->{after}  = [];

    local @ARGV = @args;
    Getopt::Long::Configure(qw(no_ignore_case bundling pass_through));
    GetOptions(
        'before=s@' => $self->{before},
        'after=s@'  => $self->{after},
    ) or Carp::croak('Unable to continue');

    $self->_install_scripts;
    $orig->( $self, @ARGV );
};

sub _install_scripts {
    my $self = shift;
    for my $type (qw(before after)){
        for my $script (@{$self->{$type}}) {
            install_modifier 'App::Prove', $type, 'run', sub {
                local $@;
                do $script;
                die $@ if $@;
            };
        }
    }
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

App::Prove::RunScripts - Run scripts around a TAP harness.

=head1 SYNOPSIS

  use App::Prove::RunScripts;

  my $app = App::Prove::RunScripts->new;
  $app->process_args(@ARGV);
  $app->run;

=head1 DESCRIPTION

Stub documentation for App::Prove::RunScripts, created by h2xs. It looks like the
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
