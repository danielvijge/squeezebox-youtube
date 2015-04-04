#!/usr/bin/perl
#
# This test suite is a port of the python test suite for
# youtube-dl
#
#  https://github.com/rg3/youtube-dl/blob/master/test/test_jsinterp.py

use Test::More tests => 19;

use Plugins::YouTube::JSInterp;

my $jsi;

$jsi = Plugins::YouTube::JSInterp->new('function x(){;}');

# Test basic
is($jsi->run('x'), undef);

$jsi = Plugins::YouTube::JSInterp->new('function x3(){return 42;}');
is($jsi->run('x3'), 42);

# Test calc
$jsi = Plugins::YouTube::JSInterp->new('function x4(a){return 2*a+1;}');
is($jsi->run('x4', 3), 7);

# Test empty return
$jsi = Plugins::YouTube::JSInterp->new('function f(){return; y()}');
is($jsi->run('f'), undef);


# Test more space
$jsi = Plugins::YouTube::JSInterp->new('function x (a) { return 2 * a + 1 ; }');
is($jsi->run('x', 3), 7);

$jsi = Plugins::YouTube::JSInterp->new('function f () { x =  2  ; return x; }');
is($jsi->run('f'), 2);

# Test strange chars
$jsi = Plugins::YouTube::JSInterp->new('function $_xY1 ($_axY1) { var $_axY2 = $_axY1 + 1; return $_axY2; }');
is($jsi->run('$_xY1', 20), 21);



# Test operators
$jsi = Plugins::YouTube::JSInterp->new('function f(){return 1 << 5;}');
is($jsi->run('f'), 32);

$jsi = Plugins::YouTube::JSInterp->new('function f(){return 19 & 21;}');
is($jsi->run('f'), 17);

$jsi = Plugins::YouTube::JSInterp->new('function f(){return 11 >> 2;}');
is($jsi->run('f'), 2);


# Test array access
$jsi = Plugins::YouTube::JSInterp->new('function f(){var x = [1,2,3]; x[0] = 4; x[0] = 5; x[2] = 7; return x;}');
is_deeply($jsi->run('f'), [5, 2, 7]);

# Test parens
$jsi = Plugins::YouTube::JSInterp->new('function f(){return (1) + (2) * ((( (( (((((3)))))) )) ));}');
is($jsi->run('f'), 7);
$jsi = Plugins::YouTube::JSInterp->new('function f(){return (1 + 2) * 3;}');
is($jsi->run('f'), 9);

# Test assignments
$jsi = Plugins::YouTube::JSInterp->new('function f(){var x = 20; x = 30 + 1; return x;}');
is($jsi->run('f'), 31);

$jsi = Plugins::YouTube::JSInterp->new('function f(){var x = 20; x += 30 + 1; return x;}');
is($jsi->run('f'), 51);

$jsi = Plugins::YouTube::JSInterp->new('function f(){var x = 20; x -= 30 + 1; return x;}');
is($jsi->run('f'), -11);


# Test array manipulation
$jsi = Plugins::YouTube::JSInterp->new('function f(){var a = "abcdef"; return a.split("");}');
is_deeply($jsi->run('f'), ["a", "b", "c", "d", "e", "f"]);

$jsi = Plugins::YouTube::JSInterp->new('function f(){var a = "abcdef"; b = a.split(""); return b.join("")}');
is_deeply($jsi->run('f'), "abcdef");


# Test comments
SKIP: {
    skip 'Skipping: Not yet fully implemented', 2;

    $jsi = Plugins::YouTube::JSInterp->new('
        function x() {
            var x = /* 1 + */ 2;
            var y = /* 30
            * 40 */ 50;
            return x + y;
        }
        ');
    is($jsi->run('x'), 52);

    $jsi = Plugins::YouTube::JSInterp->new('
        function f() {
            var x = "/*";
            var y = 1 /* comment */ + 2;
            return y;
        }
        ');
    is($jsi->run('f'), 3);
}

# Test precedence
$jsi = Plugins::YouTube::JSInterp->new('
        function x() {
            var a = [10, 20, 30, 40, 50];
            var b = 6;
            a[0]=a[b%a.length];
            return a;
        }');
is_deeply($jsi->run('x'), [20, 20, 30, 40, 50]);

