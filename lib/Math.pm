use strict;
use warnings;
use experimental qw( signatures );

package Math {

  use base qw( Clustericious::App);
  use Clustericious::RouteBuilder;
  use Clustericious::Log;

  # ABSTRACT: For testing only
  # VERSION

  get '/add/:a/:b' => sub {
    my($c) = @_;
    $c->render(autodata => [$c->param('a') + $c->param('b')]);
  };

  #sub _fib ($n)
  #{
  #  return undef if $n < 0;
  #  return 0 if $n == 0;
  #  return 1 if $n == 1 || $n == 2;
  #  return _fib($n-1) + _fib($n-2);
  #}
  #
  #get '/fib/:n' => sub {
  #  my($c) = @_;
  #  my $n = $c->param('n');
  #  $c->render(autodata => [ _fib($n) ] );
  #};
  
  get '/fib/:n' => sub {
    my($c) = @_;
    my $n = $c->param('n');
    my $client = $c->client;
    return $c->reply->not_found if $n < 0;
    return $c->render(autodata => [ 1 ]) if $n < 3;
    $c->render(autodata => [ $client->fib($n-1) + $client->fib($n-2) ]);
  };

}

1;
