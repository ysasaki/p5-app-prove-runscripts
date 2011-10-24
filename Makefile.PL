use 5.008008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'App::Prove::Around',
    VERSION_FROM  => 'lib/App/Prove/Around.pm',
    ABSTRACT_FROM => 'lib/App/Prove/Around.pm',
    AUTHOR        => 'Yoshihiro Sasaki <ysasaki at cpan.org>',
    ABSTRACT      => 'Run scripts around a TAP harness.',
    PREREQ_PM     => {
        'parent'                   => 0,
        'Class::Method::Modifiers' => '1.08',
    },
    META_MERGE => {
        resources => {
            license => 'http://dev.perl.org/licenses/',
            bugtracker =>
                'https://github.com/ysasaki/p5-app-prove-around/issues',
            repository => 'git://github.com/ysasaki/p5-app-prove-around.git',
        },
    },
    EXE_FILES => ['bin/prove_around'],
    LICENSE   => 'perl',
);
