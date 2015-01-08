require 5.008;

package Pod::SpeakIt::MacSpeech;
use strict;
use warnings;

use File::Spec::Functions qw(catfile);

my $module    = __PACKAGE__;
my $github    = 'https://github.com/briandfoy/Pod-Speakit-MacSpeech';
my $main_file = catfile( 'lib', split /::/, "$module.pm" );

my %WriteMakefile = (
	'NAME'	        => $module,
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',

	'EXE_FILES'    => [ 'bin/pod2speech' ],

	'CONFIGURE_REQUIRES' => {
		'ExtUtils::MakeMaker'   => '6.64',
		'File::Spec::Functions' => '0',
		},

	'BUILD_REQUIRES' => {
		},

	'TEST_REQUIRES' => {
		'Test::More' => '0.94',
		},

	'PREREQ_PM'     => {
		'Mac::Carbon'    => '0.77',
		'Mac::Speech'    => '0',
		'Mac::Files'     => '0',
		'Pod::PseudoPod' => '0',
		},

	'META_MERGE' => {
		'meta-spec' => { version => 2 },
		resources => {
			repository => {
				type => 'git',
				url  => "$github.git",
				web  => $github,
				},
			bugtraker => {
				web    => "$github/issues",
				},
			homepage => $github,
			},
		},

	clean  => { FILES    => q|Pod-SpeakIt-MacSpeech-*| },
	);

sub arguments { \%WriteMakefile }

do_it() unless caller;
sub do_it {
	require File::Spec;
	my $MM ='ExtUtils::MakeMaker';
	my $MM_version =
		eval{ "$MM " . $WriteMakefile{'CONFIGURE_REQUIRES'}{'ExtUtils::MakeMaker'} }
			//
		"$MM 6.64";
	eval "use $MM_version" || die "Could not load $MM_version: $@";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
