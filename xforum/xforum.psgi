use strict;
use warnings;

use xforum;

my $app = xforum->apply_default_middlewares(xforum->psgi_app);
$app;

