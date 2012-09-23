use inc::Module::Install;
name 'Spork-S5ThemeNotebook';
all_from 'lib/Spork/S5ThemeNotebook.pm';

#requires '';

test_requires 'Test::More' => '0.94';

tests 't/*.t t/*/*.t';
author_tests('xt');

auto_set_repository;

WriteAll;
