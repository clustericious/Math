use strict;
use warnings;
use Test::More;
use Test::Clustericious::Cluster;

my $cluster = Test::Clustericious::Cluster->new;
$cluster->create_cluster_ok('Math');
my $t = $cluster->t;

$t->get_ok('/add/1/2')
  ->status_is(200)
  ->json_is('/0', 3);

$t->get_ok('/fib/6')
  ->status_is(200)
  ->json_is('/0', 8);

my $client = Math::Client->new;

is $client->fib(6), 8, 'fib(6) = 8';

done_testing;

__DATA__

@@ etc/Math.conf
---
url: <%= cluster->url %>
