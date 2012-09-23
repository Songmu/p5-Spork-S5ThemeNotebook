#!/usr/bin/env perl
use 5.12.0;
use warnings;
use utf8;
use lib 'lib';
use Path::Class qw/file dir/;

use Spork::S5ThemeNotebook;

my $pm_file = file('lib/Spork/S5ThemeNotebook.pm');
my $content = $pm_file->slurp;

$content =~ s/\n=cut\n.*/\n=cut\n\n/ms;

my $fh = $pm_file->openw;

$fh->print($content);

my $asset_path = 'src';
my $dir = dir($asset_path);

$dir->recurse(
    callback => sub {
        my $file = shift;
        return unless -f $file;

        my $src_path = $file->relative;
        $src_path =~ s!^$asset_path/!!;

        $src_path = '__'.$src_path.'__';

        $fh->print($src_path."\n\n");
    },
);
$fh->close;

`perl -Ilib -MSpork::S5ThemeNotebook -E 'Spork::S5ThemeNotebook->new->compress_files("src")'`

