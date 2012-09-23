#!/usr/bin/env perl
use 5.12.0;
use warnings;
use utf8;
use Path::Class qw/file dir/;

my $pm_file = file('lib/Spork/S5ThemeNotebook.pm');
my $fh = $pm_file->open('a');

my $path = 'src';
my $dir = dir($path);

$dir->recurse(
    callback => sub {
        my $file = shift;
        return unless -f $file;

        my $src_path = $file->relative;
        $src_path =~ s!^$path/!!;

        $src_path = '__'.$src_path.'__';

        $fh->print($src_path."\n\n");
    },
);



