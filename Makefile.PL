require 5.006;
use strict;
use warnings;

my $github    = 'https://github.com/briandfoy/';
my $main_file = 'lib/Pod/SpeakIt/MacSpeech.pm';

my %WriteMakefile = (
	'NAME'	        => 'Pod::SpeakIt::MacSpeech',
	'ABSTRACT_FROM' => $main_file,
	'VERSION_FROM'  => $main_file,
	'LICENSE'       => 'perl',
	'AUTHOR'        => 'brian d foy <bdfoy@cpan.org>',

	'EXE_FILES'    => [ 'bin/pod2speech' ],
	
	'PREREQ_PM'    => { 
		'Test::More'     => '0',
		'Mac::Carbon'    => '0.77',
		'Mac::Speech'    => '0',
		'Mac::Files'     => '0',
		'Pod::PseudoPod' => '0',
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
	eval "use $MM_version";
	eval "use Test::Manifest 1.21" 
		if -e File::Spec->catfile( qw(t test_manifest) );
	WriteMakefile( %WriteMakefile );
	}


no warnings;
__PACKAGE__;
